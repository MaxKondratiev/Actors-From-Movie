//
//  OurTextField.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

class OurTextView : UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        init(textAligment: NSTextAlignment) {
            super.init(frame: .zero, textContainer: .none)
            self.textAlignment = textAlignment
           
            configure()
        }
        private func configure() {
            textColor = .label
            font = UIFont.preferredFont(forTextStyle: .body)
            textAlignment = .justified
            translatesAutoresizingMaskIntoConstraints = false
        }
    
}
