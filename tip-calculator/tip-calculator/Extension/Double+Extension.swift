/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/6.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import Foundation

extension Double {
    internal var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true : !isNormal ? false : self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
