import Foundation

extension Int {

    func eraseToCelsius() -> String {

        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "ru")

        let unit = UnitTemperature.celsius
        let measurement = Measurement(value: Double(self),
                                      unit: unit)

        let temperature = formatter.string(from: measurement)

        return temperature
    }
}
