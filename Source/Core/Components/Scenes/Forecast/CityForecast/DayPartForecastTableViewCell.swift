import UIKit

final class DayPartForecastTableViewCell: UITableViewCell {

    var model: ShortForecast? {
        didSet {
            guard let model = model else { return }

            configure(using: model)
        }
    }

    private lazy var forecastView: DayPartForecastView = {

        let view = DayPartForecastView()

        return view
    }()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        model = nil
    }

    private func configure(using model: ShortForecast) {

        forecastView.configure(using: model)
    }
}

extension DayPartForecastTableViewCell: UIConfigurable {

    func configureUI() {

        addSubviews()
        makeConstraints()
    }

    func addSubviews() {

        contentView.addSubview(forecastView)
    }

    func makeConstraints() {

        forecastView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
