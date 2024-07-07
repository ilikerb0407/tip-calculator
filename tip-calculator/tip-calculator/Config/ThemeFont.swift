/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/4.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

struct ThemeFont {
    static func regular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func bold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }

    static func demibold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
