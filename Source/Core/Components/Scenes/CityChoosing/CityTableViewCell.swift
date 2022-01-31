import UIKit

final class CityTableViewCell: UITableViewCell {

    var model: City? {

        didSet {
            guard let model = model else { return }
            configure(using: model)
        }
    }

    private func configure(using model: City) {

        textLabel?.text = model.name
    }
}

#if DEBUG

import SwiftUI

// swiftlint:disable type_name
struct CityTableViewCell_Preview: PreviewProvider {

    static var previews: some View {

        Preview {

            let cell = CityTableViewCell(
                style: .default,
                reuseIdentifier: CityTableViewCell.reuseIdentifier
            )

            cell.model = CityModel(
                id: 0,
                name: "Саратов",
                location: LocationModel(
                    latitude: 51.518491,
                    longitude: 46.021091
                )
            )

            return cell
        }
    }
}

#endif
