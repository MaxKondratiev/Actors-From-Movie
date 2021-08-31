//
//  ActorInfoVC.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit



class childActorInfoVC: UIViewController {
    
    
    let actorImageView = MovieImage(frame: .zero)
    let actorNameLabel = TitleLabels(textAligment: .center, fontSize: 26, weight: .bold)
    let birthdayLabel = SecondaryTitleLabels(textAligment: .right, fontSize: 18, weight: .medium)
    let placeOfBirthLabel = SecondaryTitleLabels(textAligment: .center, fontSize: 14, weight: .light)
    let actionButton = Buttons(backgroundColor: .systemGray2, title: "Add to favorites", borderWidth: 0)
    
    var bioLabel = OurTextView(textAligment: .center)
    var actor: ActorDetails!
    
    //DELEGATE
    //weak var delegate: ActorInformationVCDelegate!
    
    init(actor:ActorDetails) {
        super.init(nibName: nil, bundle: nil)
        self.actor = actor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
        actionButton.addTarget(self, action: #selector(actionButtonDidTapped), for: .touchUpInside)
        
    }
    
    @objc func actionButtonDidTapped() {
      
        PersistanceManager.updateWith(favorite: self.actor, actionType: .add) { [weak self] (error) in
            guard let _ = error else  {
                self?.presentAlertonMainThread(title: "Actor is your favorite!", message: "Added to your fav list ", buttonTitle: "Ok")
                return
            }
            //self?.presentAlertonMainThread(title: "Smth", message: error.localizedDescription, buttonTitle: "ok")
        }
    }
    
    func addSubviews() {
        //view.addSubview(actorNameLabel)
        view.addSubview(actorImageView)
        view.addSubview(birthdayLabel)
        view.addSubview(placeOfBirthLabel)
        view.addSubview(bioLabel)
        view.addSubview(actionButton)
    }
    
    func configureUIElements() {
        
        guard let path =  actor.profile_path else { return }
        actorImageView.downloadImage(from: "https://image.tmdb.org/t/p/w500\(path)") 
        //actorNameLabel.text = actor.name
        birthdayLabel.text = actor.birthday ?? ""
        placeOfBirthLabel.text = actor.place_of_birth ?? ""
        bioLabel.text = actor.biography ?? ""
        //bioLabel.numberOfLines = 0
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            actorImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            actorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actorImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            actorImageView.heightAnchor.constraint(equalToConstant: 240),
            
//            actorNameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: padding),
//            actorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            actorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            actorNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            birthdayLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: 10),
            birthdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            birthdayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 26),
            
            placeOfBirthLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 6),
            placeOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeOfBirthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            placeOfBirthLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: placeOfBirthLabel.bottomAnchor, constant: padding),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -padding),
           // bioLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -padding),
            
            //actionButton.topAnchor.constraint(equalTo: bioLabel.bottomAnchor,constant: 10),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.widthAnchor.constraint(equalToConstant: 140)
            
        ])
    }
}
