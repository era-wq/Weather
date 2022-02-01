import Foundation

protocol ShortForecast {

    var dayPartTitle: String { get }
    var temperature: String { get }
    var icon: URL? { get }
}
