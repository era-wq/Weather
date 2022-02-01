import Foundation

struct ServerDayPartWeather: Decodable {

    let temperature: Int?
    let icon: String?

    enum CodingKeys: String, CodingKey {

        case temperature = "temp_avg"
        case icon
    }
}

extension ServerDayPartWeather: LocalErasable {

    func eraseToLocal() -> DayPartWeather? {

        guard let temperature = temperature,
              let icon = icon else {

            return nil
        }

        let dayPart = DayPartWeather(temperature: temperature,
                                     icon: icon)

        return dayPart
    }
}
