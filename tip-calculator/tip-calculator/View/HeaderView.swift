/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/6.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

import UIKit

class HeaderView: UIView {
    private let topLabel: UILabel = LabelFactory.build(
        text: nil,
        font: ThemeFont.bold(ofSize: 18)
    )

    private let bottomLabel: UILabel = LabelFactory.build(
        text: nil,
        font: ThemeFont.regular(ofSize: 16)
    )

    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView,
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
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

    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView)
        }
    }

    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
