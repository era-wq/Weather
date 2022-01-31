import UIKit

protocol CityChoosingTableViewAdapterDelegate: AnyObject {

    func onSelection(_ city: City)
}

protocol CityChoosingTableViewAdapter {

    func setup(_ tableView: UITableView)
    func set(_ cities: [City])
}

// swiftlint:disable type_name
final class CityChoosingTableViewAdapterImp: NSObject,
                                             CityChoosingTableViewAdapter {

    private weak var tableView: UITableView?

    weak var delegate: CityChoosingTableViewAdapterDelegate?

    private var cities: [City] = []

    func setup(_ tableView: UITableView) {

        self.tableView = tableView
        self.tableView?.register(cell: CityTableViewCell.self)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
    }

    func set(_ cities: [City]) {

        self.cities = cities

        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}

extension CityChoosingTableViewAdapterImp: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        cities.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        1
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = CellResolver<CityTableViewCell>.resolve(in: tableView,
                                                           on: indexPath)

        cell.model = cities[indexPath.row]

        return cell
    }
}

extension CityChoosingTableViewAdapterImp: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? CityTableViewCell,
              let city = cell.model else { return }

        delegate?.onSelection(city)
    }
}
