final class HourForecastPresenter: HourForecastModuleOutput {

    weak var view: HourForecastViewInput?
    var interactor: HourForecastInteractorInput?
    var tableViewAdapter: HourForecastTableViewAdapter?

    private var hours: [DaysHourForecast] = []

    #if DEBUG
    deinit {
        print("HourForecastPresenter deinit")
    }
    #endif
}

extension HourForecastPresenter: HourForecastModuleInput {

    func insertWeatherIn(_ hours: [DaysHourForecast]) {

        self.hours = hours
    }
}

extension HourForecastPresenter: HourForecastViewOutput {

    func onViewDidLoad() {

        view?.setTitle(R.string.localizable.forecastHourForecastNavigationBarTitle())

        let forecast = adaptHours()

        tableViewAdapter?.set(forecast)
    }
}

extension HourForecastPresenter: HourForecastInteractorOutput {}

extension HourForecastPresenter: HourForecastTableViewAdapterDelegate {}

private extension HourForecastPresenter {

    func adaptHours() -> [HourForecast] {

        hours.compactMap { HourForecastModel(from: $0) }
    }
}
