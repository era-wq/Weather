import Foundation

#if DEBUG

import SwiftUI

struct Preview: UIViewRepresentable {

    let viewBuilder: () -> UIView

    init(_ viewBuilder: @escaping () -> UIView) {

        self.viewBuilder = viewBuilder
    }

    func makeUIView(context: Context) -> some UIView {

        viewBuilder()
    }

    func updateUIView(_ uiView: UIViewType,
                      context: Context) {}
}

#endif
