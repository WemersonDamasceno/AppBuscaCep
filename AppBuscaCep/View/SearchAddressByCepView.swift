//
//  SearchAddressByCep.swift
//  BuscaCEP
//
//  Created by Wemerson Damasceno on 28/10/24.
//

import SwiftUI

struct SearchAddressByCepView: View {
    @StateObject private var viewModel = AddressViewModel(cepService: CEPService())

    var body: some View {
        VStack(spacing: 16) {
            TextField("Digite o CEP", text: $viewModel.cepInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)

            // Exibir loading, erro ou sucesso
            switch viewModel.status {
            case .loading:
                ProgressView("Carregando...")
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
                    .font(.subheadline)
            case .success(let address):
                VStack(alignment: .leading, spacing: 4) {
                    Text(address.city)
                        .font(.headline)
                    Text(address.regionOrNeighborhood)
                        .font(.subheadline)
                    Text(address.state)
                        .font(.subheadline)
                    Text(address.street)
                        .font(.subheadline)
                }
            case .none:
                EmptyView()
            }

            Button(action: {
                viewModel.searchAddress()
            }) {
                Label("Buscar Endereço", systemImage: "magnifyingglass")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .isHidden(viewModel.status == StateEnum.loading)
        }
        .padding()
    }
}
