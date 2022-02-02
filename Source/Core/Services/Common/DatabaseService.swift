import RealmSwift
import Realm

protocol CitySaver {

    func save(_ city: City)
}

protocol WeatherSaver {

    func save(_ weather: Weather)
}

protocol WeatherFetcher {

    func fetchSavedWeather(onCompletion completion: @escaping (Weather?) -> Void)
    func observeChanges(onChange changes: @escaping (DatabaseChanges<DBWeather>) -> Void)
}

protocol CityFetcher {

    func fetchSavedCity(onCompletion completion: @escaping (City?) -> Void)
}

final class DatabaseService: NSObject {

    typealias Error = ((_ error: Swift.Error) -> Void)
    typealias SaveResponse<T> = ((Realm, T?) -> Void)
    typealias ObserveResponse<T: Object> = (Swift.Result<DatabaseChanges<T>, Swift.Error>) -> Void

    private let database: Realm

    private var tokens: [NotificationToken] = []

    override init() {

        do {
            database = try Realm()
        } catch {
            fatalError("Could not configure Realm - " + error.localizedDescription)
        }
        super.init()
    }

    deinit {

        tokens.forEach { $0.invalidate() }
    }

    func save<T: Object>(_ object: T,
                         errorBlock: @escaping Error = { _ in return },
                         block: @escaping SaveResponse<T> = { _, _ in return }) {

        do {
            try database.write {
                database.add(object)
            }
        } catch {
            errorBlock(error)
        }

        let objectReference = ThreadSafeReference(to: object)
        let configuration = database.configuration

        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: configuration)
                    try realm.write {
                        let object = realm.resolve(objectReference)
                        block(realm, object)
                    }
                } catch {
                    errorBlock(error)
                }
            }
        }

    }

    func retrieve<T: Object>(_ object: T.Type,
                             errorBlock: @escaping Error = { _ in return },
                             block: @escaping (Results<T>) -> Void) {

        let data = database.objects(T.self)

        block(data)
    }

    func observeChanges<T: Object>(
        of model: T.Type,
        onChange completion: @escaping ObserveResponse<T>
    ) {

        do {

            let configuration = database.configuration
            let realm = try Realm(configuration: configuration)

            let objects = realm.objects(model)

            let token = objects.observe { changes in

                switch changes {
                case .initial:
                    break
                case let .update(results,
                                 deletions: _,
                                 insertions: insertions,
                                 modifications: modifications):

                    let changes = DatabaseChanges(results: results,
                                                  insertions: insertions,
                                                  modifications: modifications)

                    completion(.success(changes))
                case .error(let error):
                    completion(.failure(error))
                }
            }

            tokens.append(token)

        } catch {
            completion(.failure(error))
        }
    }
}

extension DatabaseService: CitySaver {

    func save(_ city: City) {

        guard let object = (city as? CityModel)?.eraseToDatabase() else {

            return
        }

        save(object)
    }
}

extension DatabaseService: CityFetcher {

    func fetchSavedCity(onCompletion completion: @escaping (City?) -> Void) {

        retrieve(DBCity.self) { object in

            guard let object = object.first,
                  let city = object.eraseToLocal() else {
                      completion(nil)
                      return
                  }

            completion(city)
        }
    }
}

extension DatabaseService: WeatherSaver {

    func save(_ weather: Weather) {

        let model = weather.eraseToDatabase()

        save(model)
    }
}

extension DatabaseService: WeatherFetcher {

    func fetchSavedWeather(onCompletion completion: @escaping (Weather?) -> Void) {

        retrieve(DBWeather.self) { object in

            guard let object = object.first,
                  let weather = object.eraseToLocal() else {
                      completion(nil)
                      return
                  }

            completion(weather)
        }
    }

    func observeChanges(onChange completion: @escaping (DatabaseChanges<DBWeather>) -> Void) {

        observeChanges(of: DBWeather.self) { result in

            switch result {
            case .success(let changes):

                completion(changes)
            case .failure(let error):
                print(error)
            }
        }
    }
}
