//
//  UIView+LoadNib.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//

import UIKit

extension UIView {
    
    static var nibName: String {
        NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var nib: UINib {
        UINib(nibName: nibName, bundle: nil)
    }
}
