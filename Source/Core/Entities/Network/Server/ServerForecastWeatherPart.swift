import Foundation

struct ServerForecastWeatherPart: Decodable {

    let night: ServerDayPartWeather?
    let morning: ServerDayPartWeather?
    let day: ServerDayPartWeather?
    let evening: ServerDayPartWeather?
}

extension ServerForecastWeatherPart: LocalErasable {

    func eraseToLocal() -> ForecastWeatherPart? {

        guard let night = night?.eraseToLocal(),
              let morning = morning?.eraseToLocal(),
              let day = day?.eraseToLocal(),
              let evening = evening?.eraseToLocal() else {

                  return nil
              }

        let part = ForecastWeatherPart(
            night: night,
            morning: morning,
            day: day,
            evening: evening
        )

        return part
    }
}
