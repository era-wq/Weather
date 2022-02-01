import Foundation

protocol CityForecastViewInput: AnyObject {

    func isLoading(_ isLoading: Bool)
    func setTitle(_ title: String)
}
