import UIKit

final class AppCoordinatorImp: BaseCoordinator, AppCoordinator {

    var appInitialStateService: AppInitialStateService?

    func onStart() {

        appInitialStateService?.initialState { [weak self] state in

            switch state {
            case .citySelection:
                self?.startCityChoosingScene()

            case .forecast(let city):
                self?.startForecastScene(city: city)
            }
        }
    }
}

extension AppCoordinatorImp {

    func startCityChoosingScene() {

        let coordinator = CitySelectionCoordinatorAssembly.assembly(router: router)

        coordinator.onStart()
        add(coordinator)

        coordinator.onChoosingCity = { [weak self, weak coordinator] city in

            self?.startForecastScene(city: city)

            self?.remove(coordinator)
        }
    }

    func startForecastScene(city: City) {

        let scene = ForecastCoordinatorAssembly.assembly(router: router)

        scene.input.insert(city)

        scene.coordinator.onStart()

        add(scene.coordinator)
    }
}
