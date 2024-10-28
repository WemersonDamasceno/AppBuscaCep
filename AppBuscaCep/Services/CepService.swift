//
//  CepService.swift
//  BuscaCEP
//
//  Created by Wemerson Damasceno on 25/10/24.
//

import Foundation

// MARK: - Protocols e Services
protocol CEPServiceProtocol {
    func getAddressByCEP(cep: String) async throws -> AddressModel
}

class CEPService: CEPServiceProtocol {
    func getAddressByCEP(cep: String) async throws -> AddressModel {
        let urlString = "https://brasilapi.com.br/api/cep/v1/\(cep)"
        
        guard let url = URL(string: urlString) else {
            throw ResponseApiEnum.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ResponseApiEnum.requestFailed
        }
        
        switch httpResponse.statusCode {
        case 200:
            return try decodeData(data)
        case 404:
            throw ResponseApiEnum.dataNotFound
        default:
            throw ResponseApiEnum.requestFailed
        }
    }
    
    private func decodeData(_ data: Data) throws -> AddressModel {
        do {
            let cepResponse = try JSONDecoder().decode(AddressModel.self, from: data)
            return cepResponse
        } catch {
            throw ResponseApiEnum.decodingFailed
        }
    }
}
