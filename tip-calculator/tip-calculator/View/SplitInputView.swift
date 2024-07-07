/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/4.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

class SplitInputView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        backgroundColor = .brown
    }
}
