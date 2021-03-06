final class CityChoosingPresenter: CityChoosingModuleInput,
                                   CityChoosingModuleOutput {

    weak var view: CityChoosingViewInput?
    var interactor: CityChoosingInteractorInput?
    var tableViewAdapter: CityChoosingTableViewAdapter?

    var onChooseCity: ((City) -> Void)?

    #if DEBUG
    deinit {
        print("CityChoosingPresenter deinit")
    }
    #endif
}

// MARK: - CityChoosingViewOutput implementation

extension CityChoosingPresenter: CityChoosingViewOutput {

    func onViewDidLoad() {

        view?.isLoading(true)
        interactor?.obtainAvailableCities()
    }
}

// MARK: - CityChoosingInteractorOutput implementation

extension CityChoosingPresenter: CityChoosingInteractorOutput {

    func onObtainingAvaliableCities(_ cities: [City]) {

        view?.isLoading(false)
        tableViewAdapter?.set(cities)
    }
}

// MARK: - CityChoosingTableViewAdapterDelegate implementation

extension CityChoosingPresenter: CityChoosingTableViewAdapterDelegate {

    func onSelection(_ city: City) {

        interactor?.save(city)

        onChooseCity?(city)
    }
}
