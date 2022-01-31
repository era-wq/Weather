import Foundation

protocol CitiesFetcher {

    func fetchAvailableCities(onCompletion completion: @escaping ([City]) -> Void)
}

/// The stub service to simulate fetching available cities.
final class CitiesFetchService: CitiesFetcher {

    func fetchAvailableCities(onCompletion completion: @escaping ([City]) -> Void) {

        Thread.sleep(forTimeInterval: 4)

        let cities: [City] = [
            CityModel(
                id: 0,
                name: "Саратов",
                location: LocationModel(
                    latitude: 51.518491,
                    longitude: 46.021091
                )
            )
        ]

        completion(cities)
    }
}
