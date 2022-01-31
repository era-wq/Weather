import UIKit

class BaseViewController: UIViewController {

    private lazy var activityIndicator: UIActivityIndicatorView = {

        let view = UIActivityIndicatorView(style: .medium)

        view.color = .gray
        view.hidesWhenStopped = true

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
    }

    private func configureAppearance() {

        overrideUserInterfaceStyle = .light

        view.backgroundColor = .white

        addInitialSubviews()
        makeInitialConstraints()
    }

    private func addInitialSubviews() {

        view.addSubview(activityIndicator)
    }

    private func makeInitialConstraints() {

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func isContentLoading(_ flag: Bool) {

        DispatchQueue.main.async {
            if flag {
                self.activityIndicator.startAnimating()
                self.view.bringSubviewToFront(self.activityIndicator)
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
