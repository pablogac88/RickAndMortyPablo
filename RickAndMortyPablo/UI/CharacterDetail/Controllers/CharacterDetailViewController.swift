//
//  CharacterDetailViewController.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Foundation
import UIKit
import Kingfisher

protocol CharacterDetailViewProtocol: AnyObject {
    func reloadView()
}
    
class CharacterDetailViewController: UIViewController {
    var viewModel: CharacterDetailViewModelProtocol?
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.onViewLoaded()
    }
}

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    func reloadView() {
        
        guard let character = viewModel?.character,
              let locationDetail = viewModel?.detail,
              let image = URL(string: character.image) else { return }
        
        nameLabel.text = character.name
        statusLabel.text = character.status
        specieLabel.text = character.specie
        lastLocationLabel.text = character.lastLocation
        typeLabel.text = locationDetail.type
        dimensionLabel.text = locationDetail.dimension
        
        characterImageView.kf.setImage(with: image)
    }
}
