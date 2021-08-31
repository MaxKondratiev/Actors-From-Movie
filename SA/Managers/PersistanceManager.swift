//
//  PersistanceManager.swift
//  SA
//
//  Created by максим  кондратьев  on 27.08.2021.
//

import Foundation


enum PersistanceActionType {
    case add,remove
}
enum PersistanceManager {
     
    static private let defaults = UserDefaults.standard
    
    enum Keys {
     static let favorites = "favorites"
    }
    
    static func updateWith(favorite: ActorDetails,actionType:PersistanceActionType, completion: @escaping(ErrorMessages?)-> Void) {
        retrieveFavorites { (result) in
            
            switch result {
            
            case .success(let fav):
                var arrayofFavoritesActors = fav
            
                switch actionType {
                case .add:
                    guard !arrayofFavoritesActors.contains(favorite) else {
                        
                        return
                        
                    }
                    arrayofFavoritesActors.append(favorite)
                   // print(" ЭТО НАШ АРРАЙ\(arrayofFavoritesActors)")
                    
                case .remove:
                    arrayofFavoritesActors.removeAll { $0.id == favorite.id }
                }
               completion(saveFavorites(favorites: arrayofFavoritesActors))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[ActorDetails],ErrorMessages>)-> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data  else {
            completion(.success([]))
            return
        }
        do {
            let decodingData = try JSONDecoder().decode([ActorDetails].self, from: favoritesData)
            completion(.success(decodingData))
        }
        catch {
            completion(.failure(.invalidData))
        }
    }
    static func saveFavorites(favorites: [ActorDetails]) -> ErrorMessages? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }
        catch {
            return .invalidData
        }
        
    }
}
