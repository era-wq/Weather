import Foundation

protocol CityForecastViewOutput {

    var tableViewAdapter: CityForecastTableViewAdapter? { get set }

    func onViewDidLoad()
}
