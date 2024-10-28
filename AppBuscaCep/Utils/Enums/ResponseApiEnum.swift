//
//  ResponseApiEnum.swift
//  BuscaCEP
//
//  Created by Wemerson Damasceno on 27/10/24.
//

import Foundation

enum ResponseApiEnum: Error {
    case invalidURL
    case requestFailed // Este caso possui um valor associado do tipo String
    case dataNotFound
    case decodingFailed
}


