//
//  CharacterListViewModel.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Combine
import UIKit
import SwinjectStoryboard

protocol CharacterListViewModelProtocol {
    var characters: [CharactersModel] { get set}
    var favouritesList: [String] { get set}
    
    func setView(delegate: CharacterListViewProtocol?)
    func getCharacters()
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    
    var characters = [CharactersModel]()

    let network = Network()
    var respository: CharactersRepository {
        CharactersRepository(network: network)
    }

    var favouritesList: [String] = UserDefaults.standard.get()
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - DI
    private weak var viewDelegate: CharacterListViewProtocol?
    
    private var pageCounter = 1
    private var numberOfPages: Int?
    
    func setView(delegate: CharacterListViewProtocol?) {
        viewDelegate = delegate
    }
    
    func getCharacters() {
        if (numberOfPages ?? 2) > pageCounter {
            respository.getCharacters(page: pageCounter)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case let .failure(error):
                        print("Couldn't get users: \(error)")
                    case .finished: break
                    }
                }) { response in
                    self.numberOfPages = response.info.pages
                    let charactersResponse = CharactersApiToModelMapper.map(response)
                    self.characters.append(contentsOf: charactersResponse)
                    self.pageCounter += 1
                    DispatchQueue.main.async {
                        self.viewDelegate?.reloadView()
                    }
                }
                .store(in: &subscriptions)
        }
    }
}
