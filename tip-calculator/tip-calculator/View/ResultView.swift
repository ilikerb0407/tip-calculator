/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/4.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

class ResultView: UIView {
    private let headerLabel: UILabel = LabelFactory.build(text: "Total p/person",
                                                          font: ThemeFont.demibold(ofSize: 18))

    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes: [
            .font: ThemeFont.bold(ofSize: 48),
        ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24),
        ], range: NSRange(location: 0, length: 1))
        label.attributedText = text
        return label
    }()

    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView,
        ])
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    private let totalBillView: AmountView = {
        let view = AmountView(
            title: "Total bill",
            textAlignment: .left,
            amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue
        )
        return view
    }()

    private let totalTipView: AmountView = {
        let view = AmountView(
            title: "Total tip",
            textAlignment: .right,
            amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue
        )
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView,
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        layout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(result: Result) {
      let text = NSMutableAttributedString(
        string: result.amountPerPerson.currencyFormatted,
        attributes: [.font: ThemeFont.bold(ofSize: 48)])
      text.addAttributes([
        .font: ThemeFont.bold(ofSize: 24)
      ], range: NSMakeRange(0, 1))
      amountPerPersonLabel.attributedText = text

      totalBillView.configure(amount: result.totalBill)
      totalTipView.configure(amount: result.totalTip)
    }

    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }

        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }

        addShadow(offset: .init(width: 0, height: 3),
                  color: .black,
                  radius: 12.0,
                  opacity: 0.1)
    }

    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
