//
//  Buttons.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit
class Buttons: UIButton {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    // required init cuz we dont use storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Another INIT for Variety
    init(backgroundColor:UIColor,title:String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    //
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
