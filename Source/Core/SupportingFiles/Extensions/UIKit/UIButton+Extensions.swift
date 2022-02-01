import UIKit

extension UIButton {

    func setImage(_ assets: AppImage,
                  for state: UIControl.State) {

        setImage(assets.image,
                 for: state)
    }
}
