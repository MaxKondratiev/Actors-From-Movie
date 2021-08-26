//
//  AlertVC.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit

class AlertVC: UIViewController {


    let containerView = UIView()
    let titleLabel = TitleLabels(textAligment: .center, fontSize: 20,weight: .bold)
    let messageButton = BodyLabels(textAligment: .center)
    let actionButton = Buttons(backgroundColor: .systemOrange, title:   "OK")
    
    var alertTitle: String?
    var messageLabel: String?
    var buttonTitle:String?
    
    init(title:String, message:String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.messageLabel = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        // Do any additional setup after loading the view.
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 280),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "My Error"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    func configureActionButton () {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
   @objc func dismissVC()  {
      dismiss(animated: true, completion: nil)
                }
    
    func configureMessageLabel() {
        containerView.addSubview(messageButton)
        messageButton.text = messageLabel ?? "My error"
        messageButton.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            messageButton.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        
        ])
        
    }
}
