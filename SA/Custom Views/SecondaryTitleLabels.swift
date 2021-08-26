//
//  SecondTitleLabels.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

class SecondaryTitleLabels: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAligment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
       
        configure()
    }
    private func configure() {
        textColor = .secondaryLabel
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
