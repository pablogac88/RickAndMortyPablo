//
//  LocationRepository.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import Foundation
import Combine

// MARK: - Logic Controller
protocol LocationRepositoryProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getLocation(locationId: String) -> AnyPublisher<LocationDetailApiModel, Error>
}

final class LocationRepository: LocationRepositoryProtocol {
    
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getLocation(locationId: String) -> AnyPublisher<LocationDetailApiModel, Error> {
        let endpoint = Endpoint.location(locationId: locationId)
        
        return network.get(type: LocationDetailApiModel.self,
                                     url: endpoint.url)
    }
}
