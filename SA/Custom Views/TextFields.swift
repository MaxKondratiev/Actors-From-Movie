//
//  TextFields.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit

class TextFields: UITextField {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        configure()
    }
    // required init cuz we dont use storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        placeholder = "Enter a movie"
        returnKeyType = .go
        
    }
}

