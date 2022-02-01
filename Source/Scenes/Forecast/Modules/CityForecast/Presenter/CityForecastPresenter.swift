final class CityForecastPresenter: CityForecastModuleOutput,
                                   CityForecastViewOutput {

    weak var view: CityForecastViewInput?
    var interactor: CityForecastInteractorInput?
    var tableViewAdapter: CityForecastTableViewAdapter?

    var onChooseDay: (([DaysHourForecast]) -> Void)?

    private var weather: Weather?
    private var city: City?

    #if DEBUG
    deinit {
        print("CityForecastPresenter deinit")
    }
    #endif

    func onViewDidLoad() {

        view?.isLoading(true)
        setScreenTitle()

        obtainWeatherInLocation()
    }
}

extension CityForecastPresenter: CityForecastModuleInput {

    func onInsertingCity(_ city: City?) {

        self.city = city
    }
}

private extension CityForecastPresenter {

    func setScreenTitle() {

        guard let title = city?.name else { return }

        view?.setTitle(title)
    }

    func obtainWeatherInLocation() {

        guard let location = city?.location else { return }

        let forecastRequest = ForecastRequestModel(from: location)

        interactor?.obtainWeather(in: forecastRequest)
    }
}

extension CityForecastPresenter: CityForecastInteractorOutput {

    func onRequestCreationFailure() {

        view?.isLoading(false)
        print("Request Creation Failure")
    }

    func onDecodingError() {

        view?.isLoading(false)
        print("Decoding Error")
    }

    func onBadRequest() {

        view?.isLoading(false)
        print("Bad Request")
    }

    func onObtainingWeather(_ weather: Weather) {

        self.weather = weather

        let days = weather.forecastWeather.map { DayWeatherModel(from: $0) }

        view?.isLoading(false)
        tableViewAdapter?.set(days)
    }
}

// MARK: - CityForecastTableViewAdapterDelegate implementation

extension CityForecastPresenter: CityForecastTableViewAdapterDelegate {

    func onTapDay(_ day: String) {

        guard let day = weather?.forecastWeather.first(where: { $0.date == day }) else { return }

        onChooseDay?(day.hours)
    }
}
