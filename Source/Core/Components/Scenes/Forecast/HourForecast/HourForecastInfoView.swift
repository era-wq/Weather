import UIKit

final class HourForecastInfoView: UIView {

    private lazy var dateLabel: UILabel = {

        let label = label(
            fontAppearance: (15, .semibold),
            color: .black
        )

        label.setContentHuggingPriority(.defaultHigh,
                                        for: .vertical)

        return label
    }()

    private lazy var temperatureLabel: UILabel = {

        label(
            fontAppearance: (15, .regular),
            color: .gray
        )
    }()

    private lazy var weatherIconImageView: UIImageView = {

        let view = UIImageView()

        view.contentMode = .scaleAspectFit

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

    func configure(using configuration: HourForecast) {

        dateLabel.text = configuration.hour
        temperatureLabel.text = configuration.temperature

        weatherIconImageView.load(from: configuration.icon)
    }
}

extension HourForecastInfoView: UIConfigurable {

    func setInitialAppearance() {

        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }

    func configureUI() {

        setInitialAppearance()
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {

        addSubview(dateLabel)
        addSubview(temperatureLabel)
        addSubview(weatherIconImageView)
    }

    func makeConstraints() {

        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(weatherIconImageView.snp.leading).offset(-10)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateLabel.snp.leading)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(dateLabel.snp.trailing)
        }

        weatherIconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
}

private extension HourForecastInfoView {

    func label(fontAppearance: (size: CGFloat, weight: UIFont.Weight),
               color: UIColor) -> UILabel {

        let label = UILabel()

        label.font = .systemFont(ofSize: fontAppearance.size,
                                 weight: fontAppearance.weight)
        label.textColor = color

        return label
    }
}
