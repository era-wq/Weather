import Foundation

protocol CityForecastInteractorOutput: AnyObject {

    func onBadRequest()
    func onDecodingError()
    func onRequestCreationFailure()
    func onObtainingWeather(_ weather: Weather)
}
