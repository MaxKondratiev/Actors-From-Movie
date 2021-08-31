//
//  Movies.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import Foundation

struct MoviesResponse: Codable{
    let page: Int
    let results: [Moviesss]
    let total_pages: Int?
    let total_results: Int 
}

struct Moviesss: Codable, Hashable  {
    let id: Int?
    let title: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
           case title, id
            case image = "poster_path"
    }
}

struct MovieDetails: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable, Hashable {
    var id: Int
    let name: String
    let profile_path: String?
    let character: String
}

struct ActorDetails:Codable , Equatable {
    var id: Int
    let biography: String?
    let birthday: String?
    let gender: Int
    let name: String
    let place_of_birth: String?
    let profile_path: String?
    
}

struct CreditsResponse : Decodable {
    var cast: [Credits]
    var id: Int?
}
struct Credits: Decodable,Hashable {
    let title: String?
    let poster_path: String?
}
