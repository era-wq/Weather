import UIKit

final class AppCoordinatorImp: BaseCoordinator, AppCoordinator {

    func onStart() {

        startCityChoosingScene()
    }
}

extension AppCoordinatorImp {

    func startCityChoosingScene() {

        let coordinator = CitySelectionCoordinatorAssembly.assembly(router: router)

        coordinator.onStart()
        add(coordinator)

        coordinator.onChoosingCity = { [weak self, weak coordinator] _ in

            self?.remove(coordinator)
        }
    }
}
