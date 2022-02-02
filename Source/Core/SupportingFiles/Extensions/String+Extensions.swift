import UIKit

extension String {

    func eraseToIconUrl() -> URL? {

        let string = "https://yastatic.net/weather/i/icons/funky/dark/\(self).svg"

        return URL(string: string)
    }
}

extension String {

    func apply(_ font: UIFont = .systemFont(ofSize: 15),
               _ color: UIColor = .black) -> NSAttributedString {

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]

        let attributedString = NSAttributedString(string: self,
                                                  attributes: attributes)

        return attributedString
    }
}

extension String {

    func eraseToDate() -> Date? {

        let isoFormatter: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = .withFullDate
            return formatter
        }()

        return isoFormatter.date(from: self)
    }
}

extension Date {

    func eraseToReadableDate(using format: String) -> String {

        let dateFormatter: DateFormatter = {

            let formatter = DateFormatter()
            formatter.calendar = .current
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: "ru")
            return formatter
        }()

        return dateFormatter.string(from: self)
    }
}

extension Date {

    func eraseToReadableName() -> String {

        let dateFormatter: DateFormatter = {

            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            formatter.calendar = .current
            formatter.locale = Locale(identifier: "ru")
            return formatter
        }()

        return dateFormatter.string(from: self)
    }
}

extension Date {

    func eraseTo24HoursFormat() -> String? {

        let dateComponents: DateComponents = {

            var calendar = Calendar.current
            calendar.locale = Locale(identifier: "ru")
            let components = calendar.dateComponents([.hour],
                                                     from: self)
            return components
        }()

        guard let hour = dateComponents.hour else { return nil }

        return hour.eraseToString() + ":00"
    }
}

extension Double {

    func eraseToDate() -> Date {

        Date(timeIntervalSince1970: self)
    }
}

extension Int {

    func eraseToDouble() -> Double {

        Double(self)
    }

    func eraseToString() -> String {

        String(self)
    }

    func eraseToDate() -> Date {

        eraseToDouble().eraseToDate()
    }
}
