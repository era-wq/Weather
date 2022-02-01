import UIKit

final class CityForecastView: BaseViewController {

    var presenter: CityForecastViewOutput?

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
        print("CityForecastView deinit")
    }
    #endif
}

// MARK: - CityForecastViewInput implementation

extension CityForecastView: CityForecastViewInput {

    func isLoading(_ isLoading: Bool) {

        isContentLoading(isLoading)
    }

    func setTitle(_ title: String) {

        self.title = title
    }
}

// MARK: - UIConfigurable protocol implementation

extension CityForecastView: UIConfigurable {

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
