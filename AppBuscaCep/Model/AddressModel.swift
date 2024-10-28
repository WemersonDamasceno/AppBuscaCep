//
//  AddressModel.swift
//  BuscaCEP
//
//  Created by Wemerson Damasceno on 27/10/24.
//

import Foundation

// MARK: - Models e Enums
class AddressModel: Decodable {
    let cep: String
    let city: String
    let state: String
    let street: String
    let regionOrNeighborhood: String
    
    private enum CodingKeys: String, CodingKey {
        case cep, city, state, street
        case regionOrNeighborhood = "neighborhood"
    }
    
    func toString() {
        print("CEP: \(cep)")
        print("Cidade: \(city)")
        print("Estado: \(state)")
        print("Rua: \(street)")
        print("Bairro: \(regionOrNeighborhood)")
    }
}
