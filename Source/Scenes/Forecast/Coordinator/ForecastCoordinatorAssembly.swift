class ForecastCoordinatorAssembly {

    class func assembly(router: Router) -> (coordinator: (Coordinator & ForecastSceneOutput),
                                            input: ForecastSceneInput) {

        let coordinator = ForecastCoordinator(router: router)

        return (coordinator, coordinator)
    }
}
