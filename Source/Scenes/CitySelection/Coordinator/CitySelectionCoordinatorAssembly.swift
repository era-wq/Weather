// swiftlint:disable type_name
class CitySelectionCoordinatorAssembly {

    class func assembly(router: Router) -> (Coordinator & CitySelectionSceneOutput) {

        let coordinator = CitySelectionCoordinator(router: router)

        return coordinator
    }
}
