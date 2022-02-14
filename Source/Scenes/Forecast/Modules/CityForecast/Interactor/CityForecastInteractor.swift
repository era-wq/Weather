import Dispatch

final class CityForecastInteractor {

    weak var presenter: CityForecastInteractorOutput?
    var network: ForecastNetworkService?
    var database: (WeatherSaver & WeatherFetcher)? {

        didSet {
            database?.observeChanges(onChange: handleForecast(_:))
        }
    }

    private var location: Location?

    #if DEBUG
    deinit {
        print("CityForecastInteractor deinit")
    }
    #endif
}

// MARK: - CityForecastInteractorInput implementation

extension CityForecastInteractor: CityForecastInteractorInput {

    func obtainWeather(in location: ForecastRequest) {

        database?.fetchSavedWeather { [weak self] weather in

            guard let self = self else { return }

            self.obtainWeatherFromNetwork(with: location)

            if let weather = weather {

                self.presenter?.onObtainingWeather(weather)
            }
        }
    }
}

private extension CityForecastInteractor {

    func obtainWeatherFromNetwork(with model: ForecastRequest) {

        network?.fetchWeather(using: model) { [weak self] result in

                guard let self = self else { return }

                switch result {
                case .success(let serverModel):

                    guard let weather = serverModel.eraseToLocal() else {

                        self.presenter?.onDecodingError()
                        return
                    }

                    self.database?.save(weather)

                    self.presenter?.onObtainingWeather(weather)

                case .failure(let error):

                    switch error {
                    case .badRequest:
                        self.presenter?.onBadRequest()

                    case .decodingError:
                        self.presenter?.onDecodingError()

                    case .failureOnRequestCreation:
                        self.presenter?.onRequestCreationFailure()
                    }
                }
        }
    }
}

private extension CityForecastInteractor {

    func handleForecast(_ changes: DatabaseChanges<DBWeather>) {

        guard let weather = (
            changes.modifications
                .compactMap { $0.eraseToLocal() }
            +
            changes.insertions
                .compactMap { $0.eraseToLocal() })
                .first
        else { return }

        presenter?.onObtainingWeather(weather)
    }
}
