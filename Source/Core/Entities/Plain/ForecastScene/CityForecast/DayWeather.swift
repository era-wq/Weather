import Foundation

struct DayWeatherModel: DayWeather {

    let day: DisclosureHeader
    let forecast: [ShortForecast]
}

extension DayWeatherModel {

    init(from forecast: ForecastWeather) {

        let night = DayForecast(icon: forecast.parts.night.icon.eraseToIconUrl(),
                                dayPartTitle: R.string.localizable.forecastCityForecastWearherNight(),
                                temperature: forecast.parts.night.temperature.eraseToCelsius())

        let morning = DayForecast(icon: forecast.parts.morning.icon.eraseToIconUrl(),
                                  dayPartTitle: R.string.localizable.forecastCityForecastWearherMorning(),
                                  temperature: forecast.parts.morning.temperature.eraseToCelsius())

        let day = DayForecast(icon: forecast.parts.day.icon.eraseToIconUrl(),
                              dayPartTitle: R.string.localizable.forecastCityForecastWearherDay(),
                              temperature: forecast.parts.day.temperature.eraseToCelsius())

        let evening = DayForecast(icon: forecast.parts.evening.icon.eraseToIconUrl(),
                                  dayPartTitle: R.string.localizable.forecastCityForecastWearherEvening(),
                                  temperature: forecast.parts.evening.temperature.eraseToCelsius())

        self.day = DayWeatherHeader(from: forecast)
        self.forecast = [night, morning, day, evening]
    }
}

protocol DayWeather {

    var day: DisclosureHeader { get }
    var forecast: [ShortForecast] { get }
}

struct DayForecast: ShortForecast {

    let icon: URL?
    let dayPartTitle: String
    let temperature: String
}

struct DayWeatherHeader: DisclosureHeader {

    let id: String
    let title: NSAttributedString
}

extension DayWeatherHeader {

    init(from forecast: ForecastWeather) {

        let date = forecast.date.eraseToDate() ?? Date()

        let fullDate = date.eraseToReadableDate(using: "dd MMMM yyyy")
        let weekdayTitle = date.eraseToReadableName().capitalized

        let attributedTitle = weekdayTitle.apply(
            .systemFont(ofSize: 15,
                        weight: .semibold)
        )
        let attributedDate = fullDate.apply(
            .systemFont(ofSize: 15,
                        weight: .regular),
            .lightGray
        )

        let title = [attributedTitle, attributedDate].joined(with: ", ")

        self.id = forecast.date
        self.title = title
    }
}
