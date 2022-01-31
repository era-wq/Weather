import Foundation

protocol CityChoosingViewOutput {

    var tableViewAdapter: CityChoosingTableViewAdapter? { get set }

    func onViewDidLoad()
}
