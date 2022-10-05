//
//  CharactersRespository.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Foundation
import Combine

// MARK: - Logic Controller
protocol CharactersRepositoryProtocol: AnyObject {
    var network: NetworkProtocol { get }

    func getCharacters() -> AnyPublisher<CharactersApiModel, Error>
    func getCharacters(page: Int) -> AnyPublisher<CharactersApiModel, Error>
}

final class CharactersRepository: CharactersRepositoryProtocol {
    
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getCharacters() -> AnyPublisher<CharactersApiModel, Error> {
        let endpoint = Endpoint.characters
        
        return network.get(type: CharactersApiModel.self,
                                     url: endpoint.url)
    }
    
    func getCharacters(page: Int) -> AnyPublisher<CharactersApiModel, Error> {
        let endpoint = Endpoint.characters(page: page)
        
        return network.get(type: CharactersApiModel.self,
                                     url: endpoint.url)
    }
}
