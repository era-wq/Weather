import UIKit

final class DayPartForecastView: UIView {

    private lazy var dayPartTitle: UILabel = {

        label(size: 15, color: .lightGray)
    }()

    private lazy var weatherIconImageView: UIImageView = {

        let view = UIImageView()

        view.contentMode = .scaleAspectFit

        return view
    }()

    private lazy var temperatureLabel: UILabel = {

        label(size: 15, color: .black)
    }()

    private lazy var contentHStack: UIStackView = {

        let view = UIStackView(
            arrangedSubviews: [dayPartTitle,
                               temperatureLabel]
        )

        view.distribution = .equalSpacing
        view.spacing = 10

        return view
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(using configuration: ShortForecast) {

        dayPartTitle.text = configuration.dayPartTitle
        temperatureLabel.text = configuration.temperature

        weatherIconImageView.load(from: configuration.icon)
    }
}

extension DayPartForecastView: UIConfigurable {

    func configureUI() {

        addSubviews()
        makeConstraints()
    }

    func addSubviews() {

        addSubview(contentHStack)
        contentHStack.addSubview(weatherIconImageView)
    }

    func makeConstraints() {

        weatherIconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.center.equalToSuperview()
        }

        contentHStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(weatherIconImageView.snp.height)
        }
    }
}

private extension DayPartForecastView {

    func label(size: CGFloat, color: UIColor) -> UILabel {

        let label = UILabel()

        label.font = .systemFont(ofSize: size)
        label.textColor = color

        return label
    }
}

#if DEBUG

import SwiftUI

struct DayPartForecastViewPreview: PreviewProvider {

    static var previews: some View {

        Preview {
            let view = DayPartForecastView()

            // let model =
            // view.configure(using: model)

            return view
        }
    }
}
#endif
