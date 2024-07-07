/// <#Brief Description#> 
///
/// Created by TWINB00591630 on 2024/7/7.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

internal extension UIResponder {
    var parentViewController: UIViewController? {
      return next as? UIViewController ?? next?.parentViewController
    }
}
