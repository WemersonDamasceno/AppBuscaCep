//
//  AddressError.swift
//  AppBuscaCep
//
//  Created by Wemerson Damasceno on 28/10/24.
//

import Foundation

enum AddressError: Error, LocalizedError {
    case invalidInput
    case dataNotFound
    case decodingFailed
    case requestFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidInput:
            return "Por favor, informe um CEP válido."
        case .dataNotFound:
            return "Nenhum endereço encontrado para o CEP informado."
        case .decodingFailed:
            return "Erro ao decodificar os dados."
        case .requestFailed(let message):
            return message
        }
    }
}
