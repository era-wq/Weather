import UIKit

class HourForecastModuleAssembly {

    class func assembly() -> (view: UIViewController,
                              input: HourForecastModuleInput,
                              output: HourForecastModuleOutput) {

        let view = HourForecastView()
        let presenter = HourForecastPresenter()
        let interactor = HourForecastInteractor()
        let tableViewAdapter = HourForecastTableViewAdapterImp()

        tableViewAdapter.delegate = presenter

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.tableViewAdapter = tableViewAdapter

        interactor.presenter = presenter

        return (view, presenter, presenter)
    }
}
