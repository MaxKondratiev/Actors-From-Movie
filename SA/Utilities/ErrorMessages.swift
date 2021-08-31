//
//  ErrorMessages.swift
//  SA
//
//  Created by максим  кондратьев  on 24.08.2021.
//

import Foundation

enum ErrorMessages : String, Error {
    case invalidUserName = " Something wrong with username, try again"
    case unabletoComplete = "Unable to complete your request"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "Received data is invalid , try again"
    case alreadyInFav = " This actor is already in favorites!"
}
