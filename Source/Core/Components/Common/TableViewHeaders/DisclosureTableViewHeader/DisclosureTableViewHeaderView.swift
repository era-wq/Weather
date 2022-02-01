import UIKit

final class DisclosureTableHeaderView: UITableViewHeaderFooterView {

    var model: DisclosureHeader? {

        didSet {
            guard let model = model else { return }
            configure(using: model)
        }
    }

    weak var delegate: DisclosureTableHeaderViewDelegate?

    private lazy var titleLabel: UILabel = {

        let label = UILabel()

        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        label.textColor = .black

        return label
    }()

    private lazy var accessoryDisclosureButton: UIButton = {

        let button = UIButton()

        button.setImage(.arrow,
                        for: .normal)

        button.tintColor = .black
        button.addTarget(self,
                         action: #selector(onTapDisclosureButton(_:)),
                         for: .touchUpInside)

        return button
    }()

    private lazy var contentHStack: UIStackView = {

        let stack = UIStackView(
            arrangedSubviews: [titleLabel,
                               accessoryDisclosureButton]
        )

        stack.spacing = 5

        return stack
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapDisclosureButton(_ sender: UIButton) {

        guard let model = model else { return }
        delegate?.onDisclosureTap(model)
    }

    func configure(using configuration: DisclosureHeader) {

        titleLabel.setAttributedText(configuration.title)
    }
}

extension DisclosureTableHeaderView: UIConfigurable {

    func setInitialAppearance() {

        contentView.backgroundColor = .white
    }

    func configureUI() {

        setInitialAppearance()
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {

        contentView.addSubview(contentHStack)
    }

    func makeConstraints() {

        contentHStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        accessoryDisclosureButton.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
    }

}

#if DEBUG

import SwiftUI

// swiftlint:disable type_name
struct DisclosureTableHeaderViewPreview: PreviewProvider {

    static var previews: some View {

        Preview {

            let view = DisclosureTableHeaderView(reuseIdentifier: DisclosureTableHeaderView.reuseIdentifier)

            let model = DayWeatherHeader(id: "dasd", title: NSAttributedString(string: "Ghbdtn"))
            view.model = model

            return view
        }
    }
}
#endif
