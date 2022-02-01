import UIKit

class CityForecastModuleAssembly {

    class func assembly() -> (view: UIViewController,
                              input: CityForecastModuleInput,
                              output: CityForecastModuleOutput) {

        let view = CityForecastView()
        let presenter = CityForecastPresenter()
        let interactor = CityForecastInteractor()
        let tableViewAdapter = CityForecastTableViewAdapterImp()

        tableViewAdapter.delegate = presenter

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.tableViewAdapter = tableViewAdapter

        let network: NetworkManager? = DIContainer.shared.resolve()
        let database: DatabaseService? = DIContainer.shared.resolve()

        interactor.presenter = presenter
        interactor.network = network
        interactor.database = database

        return (view, presenter, presenter)
    }
}
