import Foundation

protocol HourForecast {

    var hour: String { get }
    var temperature: String { get }
    var icon: URL? { get }
}

struct HourForecastModel: HourForecast {

    let hour: String
    let temperature: String
    let icon: URL?
}

extension HourForecastModel {

    init?(from model: DaysHourForecast) {

        guard let hour = model.hourTimeStamp.eraseToDate().eraseTo24HoursFormat() else {

            return nil
        }

        let model = HourForecastModel(
            hour: hour,
            temperature: model.temperature.eraseToCelsius(),
            icon: model.icon.eraseToIconUrl()
        )

        self = model
    }
}
