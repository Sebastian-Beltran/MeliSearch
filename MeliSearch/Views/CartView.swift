//
//  CartView.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 1/03/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                if appState.cart.isEmpty {
                    Text("Tu carrito está vacío")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                    Image(systemName: "cart")
                        .font(.title2)
                        .foregroundColor(.gray)

                } else {
                    List {
                        ForEach(appState.cart) { product in
                            HStack {
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)

                                VStack(alignment: .leading) {
                                    Text(product.title)
                                        .font(.headline)
                                    if(product.originalPrice != nil)
                                    {
                                        Text("$\(product.originalPrice!, specifier: "%.2f")")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .strikethrough(true, color: .gray)
                                    }
                                    Text("$\(product.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                }

                                Spacer()

                                Button(action: {
                                    appState.removeFromCart(product: product)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tu carrito (\(appState.cart.count))")
        }
    }
}

