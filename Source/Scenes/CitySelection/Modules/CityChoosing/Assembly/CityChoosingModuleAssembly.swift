import UIKit

class CityChoosingModuleAssembly {

    class func assembly() -> (view: UIViewController,
                              output: CityChoosingModuleOutput) {

        let view = CityChoosingView()
        let presenter = CityChoosingPresenter()
        let interactor = CityChoosingInteractor()
        let tableViewAdapter = CityChoosingTableViewAdapterImp()

        tableViewAdapter.delegate = presenter

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.tableViewAdapter = tableViewAdapter

        interactor.presenter = presenter
        interactor.network = DIContainer.shared.resolve()
        interactor.database = DIContainer.shared.resolve()

        return (view, presenter)
    }
}
