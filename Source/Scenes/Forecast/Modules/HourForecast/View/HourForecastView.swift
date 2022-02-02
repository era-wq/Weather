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

extension HourForecastView: HourForecastViewInput {

    func setTitle(_ title: String) {

        self.title = title
    }
}

// MARK: - UIConfigurable protocol implementation

extension HourForecastView: UIConfigurable {

    func configureUI() {

        addSubviews()
        makeConstraints()
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
