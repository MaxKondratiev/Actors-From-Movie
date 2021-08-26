//
//  DetailsCell.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    static let reuseId = "ActorCell"
    let actorImage = MovieImage(frame: .zero)
    let actorName = TitleLabels(textAligment: .center, fontSize: 20,weight: .bold)
    let characterName = TitleLabels(textAligment: .center, fontSize: 14, weight: .light)
    let padding : CGFloat = 8
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(actor : Cast) {
        actorName.text = actor.name
        characterName.text = actor.character
        guard let path =  actor.profile_path else {
            return
        }
        actorImage.downloadImage(from: "https://image.tmdb.org/t/p/w500\(path)")
        
    }
    
    
    func configure() {
        
        addSubview(actorImage)
        addSubview(actorName)
        addSubview(characterName)
       
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            actorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            actorImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            actorImage.heightAnchor.constraint(equalTo: actorImage.widthAnchor),
            
            
            actorName.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: 12),
            actorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            actorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            actorName.heightAnchor.constraint(equalToConstant: 24),
            
            characterName.topAnchor.constraint(equalTo: actorName.bottomAnchor, constant: 5),
            characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            characterName.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
