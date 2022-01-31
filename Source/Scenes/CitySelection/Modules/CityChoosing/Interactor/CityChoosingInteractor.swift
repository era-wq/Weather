import Dispatch

final class CityChoosingInteractor {

    weak var presenter: CityChoosingInteractorOutput?
    var network: CitiesFetchService?
    var database: CitySaver?

    #if DEBUG
    deinit {
        print("CityChoosingInteractor deinit")
    }
    #endif
}

// MARK: - CityChoosingInteractorInput implementation

extension CityChoosingInteractor: CityChoosingInteractorInput {

    func save(_ city: City) {

        DispatchQueue.global().async {

            self.database?.save(city)
        }
    }

    func obtainAvailableCities() {

        DispatchQueue.global().async { [weak self] in

            self?.network?.fetchAvailableCities { cities in

                self?.presenter?.onObtainingAvaliableCities(cities)
            }
        }
    }
}
