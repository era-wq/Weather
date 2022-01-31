import RealmSwift
import Realm

protocol CitySaver {

    func save(_ city: City)
}

protocol CityFetcher {

    func fetchSavedCity(onCompletion completion: @escaping (City?) -> Void)
}

final class DatabaseService: NSObject {

    typealias Error = ((_ error: Swift.Error) -> Void)
    typealias SaveResponse<T> = ((Realm, T?) -> Void)

    private let database: Realm

    override init() {

        do {
            database = try Realm()
        } catch {
            fatalError("Could not configure Realm - " + error.localizedDescription)
        }
        super.init()
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
}

extension DatabaseService: CitySaver {

    func save(_ city: City) {

        let cityObject = DBCity()
        let locationObject = DBLocation()

        locationObject.latitude = city.location.latitude
        locationObject.longitude = city.location.longitude

        cityObject.id = city.id
        cityObject.name = city.name
        cityObject.location = locationObject

        save(cityObject)
    }
}

extension DatabaseService: CityFetcher {

    func fetchSavedCity(onCompletion completion: @escaping (City?) -> Void) {

        retrieve(DBCity.self) { object in

            guard let object = object.first,
                  let location = object.location else {
                      completion(nil)
                      return
                  }

            let cityCoordinates = LocationModel(latitude: location.latitude,
                                                longitude: location.longitude)
            let city = CityModel(id: object.id,
                                 name: object.name,
                                 location: cityCoordinates)

            completion(city)
        }
    }
}
