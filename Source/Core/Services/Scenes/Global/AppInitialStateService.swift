import Foundation

protocol AppInitialStateService {

    func initialState(onCompletion completion: @escaping (AppInitialState) -> Void)
}

final class AppInitialStateServiceImp: AppInitialStateService {

    private let database: CityFetcher

    init(database: CityFetcher) {

        self.database = database
    }

    func initialState(onCompletion completion: @escaping (AppInitialState) -> Void) {

        database.fetchSavedCity { city in

            guard let city = city else {

                completion(.citySelection)
                return
            }

            completion(.forecast(city))
        }
    }
}
