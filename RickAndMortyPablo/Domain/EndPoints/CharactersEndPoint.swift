//
//  CharactersEndPoint.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Foundation

extension Endpoint {
    static var characters: Self {
        return Endpoint(path: "/character")
    }
    
    static func characters(page: Int) -> Self {
        return Endpoint(path: "/character",
                        queryItems: [
                            URLQueryItem(name: "page",
                                         value: "\(page)")
            ]
        )
    }
}
