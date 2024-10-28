//
//  AddressViewModel.swift
//  BuscaCEP
//
//  Created by Wemerson Damasceno on 28/10/24.
//

import Foundation
import Combine

class AddressViewModel: ObservableObject {
    @Published var cepInput: String = ""
    @Published var status: StateEnum?
    
    private let cepService: CEPServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(cepService: CEPServiceProtocol) {
        self.cepService = cepService
    }
    
    func searchAddress() {
        guard !cepInput.isEmpty else {
            status = .error(AddressError.invalidInput.errorDescription!)
            return
        }
        
        status = .loading
        
        fetchAddress(cep: cepInput)
            .receive(on: DispatchQueue.main)
            .sink {
                completion in
                if case .failure(let error) = completion {
                    self.handleError(error)
                }
            }
        receiveValue: { address in
            self.status = .success(address)
        }
        .store(in: &cancellables)
    }
    
    private func fetchAddress(cep: String) -> AnyPublisher<AddressModel, Error> {
        Future { promise in
            Task {
                do {
                    let address = try await self.cepService.getAddressByCEP(cep: cep)
                    promise(.success(address))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func handleError(_ error: Error) {
        if let apiError = error as? ResponseApiEnum {
            switch apiError {
            case .dataNotFound:
                status = .error(AddressError.dataNotFound.errorDescription!)
            case .decodingFailed:
                status = .error(AddressError.decodingFailed.errorDescription!)
            case .requestFailed:
                status = .error("Ops! Algo deu errado. Tente novamente.")
            default:
                status = .error("Erro desconhecido.")
            }
        } else {
            status = .error("Erro inesperado: \(error.localizedDescription)")
        }
    }
}
