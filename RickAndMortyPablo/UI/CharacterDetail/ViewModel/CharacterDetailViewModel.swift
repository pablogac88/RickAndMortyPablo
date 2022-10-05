//
//  CharacterDetailViewModel.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Combine
import UIKit

protocol CharacterDetailViewModelProtocol {
    var detail: LocationDetailApiModel? { get set}
    var character: CharactersModel? { get set }
    
    func setView(delegate: CharacterDetailViewProtocol?)
    func onViewLoaded()
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    var detail: LocationDetailApiModel?
    var character: CharactersModel?
    
    // MARK: - DI
    private weak var viewDelegate: CharacterDetailViewProtocol?

    var respository: LocationRepository {
        LocationRepository(network: Network())
    }

    var subscriptions = Set<AnyCancellable>()
    
    func setView(delegate: CharacterDetailViewProtocol?) {
        viewDelegate = delegate
    }
    
    func onViewLoaded() {
        
        if let locationId = character?.locationId {
            respository.getLocation(locationId: locationId)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case let .failure(error):
                        print("Couldn't get users: \(error)")
                    case .finished: break
                    }
                }) { response in
                    self.detail = response
                    DispatchQueue.main.async {
                        self.viewDelegate?.reloadView()
                    }
                }
                .store(in: &subscriptions)
        }
    }
}
