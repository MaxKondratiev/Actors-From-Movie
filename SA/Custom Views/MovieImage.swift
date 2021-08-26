//
//  MovieImage.swift
//  SA
//
//  Created by максим  кондратьев  on 24.08.2021.
//

import UIKit

class MovieImage: UIImageView {
    
    let placeholderImage = UIImage(systemName: "person.circle")
    
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func  configure() {
        layer.cornerRadius = 20
        //layer.cornerRadius  = frame.size.height
        contentMode = .scaleAspectFill
        
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = placeholderImage
    }
    
    func downloadImage(from urlString: String) {
        //we are not handling Errors here (cuz we have default image) and that's why this method is here and not inside of NetworkManager
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
        }
        guard  let url = URL(string: urlString) else {  return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            guard let self = self else {return}
            
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data  else {return}
            guard let imagefromData = UIImage(data: data) else {return}
            
            self.cache.setObject(imagefromData, forKey: cacheKey)
            print(self.cache)
            
            DispatchQueue.main.async {
                self.image = imagefromData
            }
        }
        task.resume()
    }
}
