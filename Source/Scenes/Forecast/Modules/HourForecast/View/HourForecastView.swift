import UIKit

final class HourForecastView: BaseViewController {

    var presenter: HourForecastViewOutput?

    private lazy var tableView: UITableView = {

        let tableView = UITableView()

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.tableViewAdapter?.setup(tableView)

        configureUI()

        presenter?.onViewDidLoad()
    }

    #if DEBUG
    deinit {
        print("HourForecastView deinit")
    }
    #endif
}

// MARK: - HourForecastViewInput implementation

extension HourForecastView: HourForecastViewInput {}

// MARK: - UIConfigurable protocol implementation

extension HourForecastView: UIConfigurable {

    func configureUI() {

        setInitialAppearance()
        addSubviews()
        makeConstraints()
    }

    func setInitialAppearance() {

        title = Appearance.navigationBarTitle
    }

    func addSubviews() {

        view.addSubview(tableView)
    }

    func makeConstraints() {

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
}

private extension HourForecastView {

    enum Appearance {

        static let navigationBarTitle = R.string.localizable.forecastHourForecastNavigationBarTitle()
    }
}
