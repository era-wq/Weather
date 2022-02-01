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

        module.output.onChooseDay = { [weak self] _ in

            // hours screen
        }

        router.root(module.view, animated: true)
    }
}
