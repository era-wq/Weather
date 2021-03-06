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

        let network: CitiesFetchService? = DIContainer.shared.resolve()
        let database: DatabaseService? = DIContainer.shared.resolve()

        interactor.presenter = presenter
        interactor.network = network
        interactor.database = database

        return (view, presenter)
    }
}
