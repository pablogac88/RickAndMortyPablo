//
//  CharactersMapper.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//

import Foundation

protocol CharactersApiToModelMapperProtocol {
    static func map(_ productDetail: CharactersApiModel?) -> [CharactersModel]
}

class CharactersApiToModelMapper: CharactersApiToModelMapperProtocol {
    static func map(_ model: CharactersApiModel?) -> [CharactersModel] {
        
        var characters = [CharactersModel]()
        
        model?.characters.forEach { character in
            let locationUrl = character.location.url
            if let locationId = locationUrl.components(separatedBy: "/").last {
                
                characters.append(CharactersModel(idCharacter: character.id,
                                                  name: character.name,
                                                  image: character.image,
                                                  lastLocation: character.location.name,
                                                  originLocation: character.origin.name,
                                                  locationId: locationId,
                                                  status: character.status.rawValue,
                                                  specie: character.species))
            }
        }
        return characters
        
    }
    
}
