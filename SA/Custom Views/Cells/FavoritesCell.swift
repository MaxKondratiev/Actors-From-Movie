//
//  FavoritesCell.swift
//  SA
//
//  Created by максим  кондратьев  on 27.08.2021.
//

import UIKit

class FavoritesCell: UITableViewCell {

    static let reuseId = "FavoriteCell"
   
   let avatarImage = MovieImage(frame: .zero)
    let userNameLabel = TitleLabels(textAligment: .left, fontSize: 26,weight: .medium)
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(fav: ActorDetails){
        userNameLabel.text = fav.name
        guard let path = fav.profile_path else {
            return
        }
        avatarImage.downloadImage(from: "https://image.tmdb.org/t/p/w500\(path)")
       
    }
    
    private func configure() {
        addSubview(avatarImage)
        addSubview(userNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
}
