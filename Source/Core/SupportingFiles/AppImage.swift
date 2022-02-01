import UIKit

enum AppImage: String {

    case arrow = "chevron.right"
}

extension AppImage {

    var image: UIImage? {

        UIImage(systemName: rawValue)
    }
}
