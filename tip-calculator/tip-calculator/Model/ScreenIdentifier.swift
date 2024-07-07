/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/6.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import Foundation

enum ScreenIdentifier {
    enum LogoView: String {
        case logoView
    }

    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }

    enum BillInputView: String {
        case textField
    }

    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }

    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
}
