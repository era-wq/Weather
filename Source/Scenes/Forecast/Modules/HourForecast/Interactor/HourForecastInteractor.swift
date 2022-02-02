final class HourForecastInteractor {

    weak var presenter: HourForecastInteractorOutput?

    #if DEBUG
    deinit {
        print("HourForecastInteractor deinit")
    }
    #endif
}

// MARK: - HourForecastInteractorInput implementation

extension HourForecastInteractor: HourForecastInteractorInput {}
