//
//  ProductDetailView.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.thumbnail)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("Error al cargar la imagen")
                            .foregroundColor(.red)
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 300)
                .cornerRadius(10)

                Text(product.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.green)

                Button(action: {
                    if let url = URL(string: product.permalink) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Ver en MercadoLibre")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

