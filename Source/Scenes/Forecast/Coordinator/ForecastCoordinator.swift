protocol ForecastSceneInput {

    func insert(_ city: City)
}

protocol ForecastSceneOutput {}

final class ForecastCoordinator: BaseCoordinator,
                                 Coordinator,
                                 ForecastSceneOutput {

    private var city: City?

    #if DEBUG
    deinit {
        print("ForecastCoordinator deinit")
    }
    #endif

    func onStart() {

        showForecastInCity(city)
    }
}

// MARK: - ForecastSceneInput implementation

extension ForecastCoordinator: ForecastSceneInput {

    func insert(_ city: City) {

        self.city = city
    }
}

private extension ForecastCoordinator {

    func showForecastInCity(_ city: City?) {

        var module = CityForecastModuleAssembly.assembly()

        module.input.onInsertingCity(city)

        module.output.onChooseDay = { [weak self] hours in

            self?.showHourForecast(using: hours)
        }

        router.root(module.view, animated: true)
    }

    func showHourForecast(using hours: [DaysHourForecast]) {

        let module = HourForecastModuleAssembly.assembly()

        module.input.insertWeatherIn(hours)

        router.push(module.view, animated: true)
    }
}
