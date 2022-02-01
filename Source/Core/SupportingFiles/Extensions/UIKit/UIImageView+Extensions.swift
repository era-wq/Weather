import Kingfisher
import UIKit
import SVGKit

extension UIImageView {

    func load(from url: URL?,
              placeholder: UIImage? = nil) {

        guard let url = url else {

            image = placeholder
            return
        }
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .processor(SVGImgProcessor())
            ]
        ) { [weak self] result in

            switch result {
            case .success(let imageData):
                self?.image = imageData.image
            default:
                return
            }
        }

    }
}
