//
//  LocationEndPoint.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Foundation

extension Endpoint {
    static func location(locationId: String) -> Self {
        return Endpoint(path: "/location/\(locationId)")
    }
}
