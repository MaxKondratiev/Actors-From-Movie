//
//  NetworkManager.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://imdb-api.com/"
    private let baseUrl2 = "https://api.themoviedb.org/3/search/movie?api_key="
    let apiKey = "c162ec14381777d273ba146aab9691be"
    
    let cache = NSCache<NSString,UIImage>()
    private init() {}
    
    func getMovies(for movieName: String,page: Int, completion: @escaping (Result<[Moviesss], ErrorMessages>)->Void) {
        let endpoint = "\(baseUrl2)\(apiKey)&query=\(movieName)&page=\(page)"
        print (endpoint)
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUserName))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unabletoComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidData))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            //print("OUR DATAAAA\(String(data: data, encoding: .utf8))")
            
            do {
                let responseData = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(responseData.results))
            }
            catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
        func getMoviesDetails(for movieName: Int, completion: @escaping (Result<[Cast], ErrorMessages>)->Void) {
           // let endpoint1 = "\(baseUrl2)\(apiKey)&query=\(movieName)&page=\(page)"
            let endpoint = "https://api.themoviedb.org/3/movie/\(movieName)/credits?api_key=c162ec14381777d273ba146aab9691be&language=en-US"
            print (endpoint)
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(.invalidUserName))
                return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    completion(.failure(.unabletoComplete))
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidData))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                //print("OUR DATAAAA\(String(data: data, encoding: .utf8) ?? "")")
                
                do {
                    let responseData = try JSONDecoder().decode(MovieDetails.self, from: data)
                    completion(.success(responseData.cast))
                }
                catch {
                    completion(.failure(.invalidData))
                }
            }
            task.resume()
    }
    
    func getActorInfo(for movieName: Int, completion: @escaping (Result<ActorDetails, ErrorMessages>)->Void) {
       // let endpoint1 = "\(baseUrl2)\(apiKey)&query=\(movieName)&page=\(page)"
        //https://api.themoviedb.org/3/person/73457?api_key=c162ec14381777d273ba146aab9691be&language=en-US
        let endpoint = "https://api.themoviedb.org/3/person/\(movieName)?api_key=c162ec14381777d273ba146aab9691be&language=en-US"
        //print (endpoint)
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUserName))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unabletoComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidData))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            //print("OUR DATAAAA\(String(data: data, encoding: .utf8) ?? "")")
            
            do {
                let responseData = try JSONDecoder().decode(ActorDetails.self, from: data)
                completion(.success(responseData))
            }
            catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
}
    
   
     func getAllMoviesOfActor(for actor: Int, completion: @escaping (Result<[Credits], ErrorMessages>)->Void) {
       
         //https://api.themoviedb.org/3/person/73457?api_key=c162ec14381777d273ba146aab9691be&language=en-US
         let endpoint = "https://api.themoviedb.org/3/person/\(actor)/movie_credits?api_key=c162ec14381777d273ba146aab9691be&language=en-US"
         print (endpoint)
         
         guard let url = URL(string: endpoint) else {
             completion(.failure(.invalidUserName))
            print("ДАльше не пошло")
             return }
         
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
             if let _ = error {
                 completion(.failure(.unabletoComplete))
             }
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                 completion(.failure(.invalidData))
                 return
             }
             guard let data = data else {
                 completion(.failure(.invalidData))
                print("что-то не так")
                 return
             }
             //print("OUR DATAAAA\(String(data: data, encoding: .utf8) ?? "")")
             
             do {
                 let responseData = try JSONDecoder().decode(CreditsResponse.self, from: data)
                completion(.success(responseData.cast))
                
             }
             catch {
                 completion(.failure(.invalidData))
             }
         }
         task.resume()
    }
}
