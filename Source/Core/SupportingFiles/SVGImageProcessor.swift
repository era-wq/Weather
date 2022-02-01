import Foundation
import Kingfisher
import SVGKit

struct SVGImgProcessor: ImageProcessor {

    var identifier: String = Bundle.main.bundleIdentifier ?? ""

    func process(item: ImageProcessItem,
                 options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {

        switch item {
        case .image(let image):
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
