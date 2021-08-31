//
//  AllMoviesCell.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

class AllMoviesCell: UICollectionViewCell {
        
        static let  reuseID = "AllMoviesCell"
        let moviePoster = MovieImage(frame: .zero)
        let movieTitleLabel = TitleLabels(textAligment: .center, fontSize: 14,weight: .bold)
        
         
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
            movieTitleLabel.numberOfLines = 0
           
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func sett(actor: Credits){
            movieTitleLabel.text = actor.title ?? ""
            guard let path = actor.poster_path else { return }
            
            moviePoster.downloadImage(from: "https://image.tmdb.org/t/p/w500\(path)")
        }
        let padding: CGFloat = 8
        
        func configure() {
            addSubview(moviePoster)
            addSubview(movieTitleLabel )
            NSLayoutConstraint.activate([
                moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                moviePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                moviePoster.heightAnchor.constraint(equalTo: moviePoster.widthAnchor),
                
                
                movieTitleLabel.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 10),
                movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                movieTitleLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }


