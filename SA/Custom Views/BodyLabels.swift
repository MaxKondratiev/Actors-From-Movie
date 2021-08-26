//
//  BodyLabels.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//


import UIKit

class BodyLabels: UILabel {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
           
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        init(textAligment: NSTextAlignment) {
            super.init(frame: .zero)
            self.textAlignment = textAlignment
           
            configure()
        }
        private func configure() {
            textColor = .label
            font = UIFont.preferredFont(forTextStyle: .body)
            adjustsFontSizeToFitWidth = true
            minimumScaleFactor = 0.8
            lineBreakMode = .byTruncatingTail
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
