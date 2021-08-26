//
//  MovieCell.swift
//  SA
//
//  Created by максим  кондратьев  on 24.08.2021.
//

import UIKit

class MovieCell : UICollectionViewCell {
    
    static let  reuseID = "MovieCell"
    let moviePoster = MovieImage(frame: .zero)
    let movieTitleLabel = TitleLabels(textAligment: .center, fontSize: 16,weight: .bold)
    
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Moviesss){
        movieTitleLabel.text = movie.title
        moviePoster.downloadImage(from: "https://image.tmdb.org/t/p/w500\(movie.image)" )
        
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
            
            
            movieTitleLabel.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 12),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
