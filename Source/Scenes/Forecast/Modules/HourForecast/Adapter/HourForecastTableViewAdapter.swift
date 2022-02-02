import UIKit

protocol HourForecastTableViewAdapterDelegate: AnyObject {
}

protocol HourForecastTableViewAdapter {

    func setup(_ tableView: UITableView)
    func set(_ forecast: [HourForecast])
}

// swiftlint:disable type_name
final class HourForecastTableViewAdapterImp: NSObject,
                                             HourForecastTableViewAdapter {

    private var tableView: UITableView?

    weak var delegate: HourForecastTableViewAdapterDelegate?

    private var forecast: [HourForecast] = []

    func setup(_ tableView: UITableView) {

        self.tableView = tableView
        self.tableView?.register(cell: HourForecastTableViewCell.self)
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.allowsSelection = false
        self.tableView?.separatorStyle = .none
        self.tableView?.dataSource = self
        self.tableView?.rowHeight = UITableView.automaticDimension
    }

    func set(_ forecast: [HourForecast]) {

        self.forecast = forecast

        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}

extension HourForecastTableViewAdapterImp: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        forecast.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = CellResolver<HourForecastTableViewCell>.resolve(in: tableView,
                                                                   on: indexPath)

        cell.model = forecast[indexPath.row]
        return cell
    }
}
