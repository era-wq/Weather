import UIKit

final class CityChoosingView: BaseViewController {

    var presenter: CityChoosingViewOutput?

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
        print("CityChoosingView deinit")
    }
    #endif
}

// MARK: - CityChoosingViewInput implementation

extension CityChoosingView: CityChoosingViewInput {

    func isLoading(_ isLoading: Bool) {

        isContentLoading(isLoading)
    }
}

// MARK: - UIConfigurable protocol implementation

extension CityChoosingView: UIConfigurable {

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
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

private extension CityChoosingView {

    enum Appearance {

        static let navigationBarTitle = R.string.localizable.citySelectionChoosingNavigationBarTitle()
    }
}
