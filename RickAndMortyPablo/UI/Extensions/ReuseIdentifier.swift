//
//  ReuseIdentifier.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}
