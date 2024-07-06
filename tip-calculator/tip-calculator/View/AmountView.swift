/// <#Brief Description#> 
///
/// Created by TWINB00591630 on 2024/7/6.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

class AmountView: UIView {

  private let title: String
  private let textAlignment: NSTextAlignment
  private let amountLabelIdentifier: String

  private lazy var titleLabel: UILabel = {
    LabelFactory.build(
      text: title,
      font: ThemeFont.regular(ofSize: 18),
      textColor: ThemeColor.text,
      textAlignment: textAlignment)
  }()

  private lazy var amountLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = textAlignment
    label.textColor = ThemeColor.primary
    let text = NSMutableAttributedString(
      string: "$0",
      attributes: [
        .font: ThemeFont.bold(ofSize: 24)
      ])
    text.addAttributes([
      .font: ThemeFont.bold(ofSize: 16)
    ], range: NSMakeRange(0, 1))
    label.attributedText = text
    label.accessibilityIdentifier = amountLabelIdentifier
    return label
  }()

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      titleLabel,
      amountLabel
    ])
    stackView.axis = .vertical
    return stackView
  }()

  init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
    self.title = title
    self.textAlignment = textAlignment
    self.amountLabelIdentifier = amountLabelIdentifier
    super.init(frame: .zero)
    layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }

  private func layout() {
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
