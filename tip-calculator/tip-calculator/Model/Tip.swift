/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/7.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import Foundation

enum Tip {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)

    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case let .custom(value):
            return String(value)
        }
    }
}
