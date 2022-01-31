protocol CitySelectionSceneOutput: AnyObject {

    var onChoosingCity: ((City) -> Void)? { get set }
}

final class CitySelectionCoordinator: BaseCoordinator,
                                      Coordinator,
                                      CitySelectionSceneOutput {

    var onChoosingCity: ((City) -> Void)?

    #if DEBUG
    deinit {
        print("CitySelectionCoordinator deinit")
    }
    #endif

    func onStart() {

        var module = CityChoosingModuleAssembly.assembly()

        module.output.onChooseCity = { [weak self] city in

            self?.onChoosingCity?(city)
        }

        router.root(module.view, animated: true)
    }
}
