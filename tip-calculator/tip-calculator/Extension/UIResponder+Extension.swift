/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/7.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

extension UIResponder {
    internal var parentViewController: UIViewController? {
        next as? UIViewController ?? next?.parentViewController
    }
}
