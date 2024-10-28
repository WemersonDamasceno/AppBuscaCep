//
//  StateEnum.swift
//  AppBuscaCep
//
//  Created by Wemerson Damasceno on 28/10/24.
//

import Foundation

enum StateEnum: Equatable {
    case loading
    case error(String)
    case success(AddressModel)

    static func == (lhs: StateEnum, rhs: StateEnum) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(let message1), .error(let message2)):
            return message1 == message2
        case (.success(let address1), .success(let address2)):
            return address1.cep == address2.cep
        default:
            return false
        }
    }
}

