//
//  UserStoreProvider.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Foundation

protocol UserStoreProviderProtocol: AnyObject {
    func get() -> [String]
    func set(_ value: [String])
    func removeFavourites()
}

extension UserDefaults: UserStoreProviderProtocol {
    func get() -> [String] {
        object(forKey: "favourite") as? [String] ?? [String]()
    }

    func set(_ value: [String]) {
        set(value, forKey: "favourite")
    }

    func removeFavourites() {
        removeObject(forKey: "favourite")
    }
}
