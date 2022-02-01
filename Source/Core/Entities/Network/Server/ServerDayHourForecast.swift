import Foundation

struct ServerDaysHourForecast: Decodable {

    let hourTimeStamp: Int?
    let temperature: Int?
    let icon: String?

    enum CodingKeys: String, CodingKey {

        case hourTimeStamp = "hour_ts"
        case temperature = "temp"
        case icon
    }
}

extension ServerDaysHourForecast: LocalErasable {

    func eraseToLocal() -> DaysHourForecast? {

        guard let hourTimeStamp = hourTimeStamp,
              let temperature = temperature,
              let icon = icon else {
                  return nil
              }

        let url = URL(string: icon)

        let hourForecast = DaysHourForecast(
            hourTimeStamp: hourTimeStamp,
            temperature: temperature,
            icon: url
        )

        return hourForecast
    }
}
