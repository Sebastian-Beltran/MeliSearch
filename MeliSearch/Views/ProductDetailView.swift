//
//  ProductDetailView.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if(product.condition == "new")
                {
                    Text("Nuevo")
                        .font(.caption)
                        .foregroundColor(.gray)

                } else {
                    Text("Usado")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

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


                if(product.originalPrice != nil)
                {
                    Text("$\(product.originalPrice!, specifier: "%.2f")")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .strikethrough(true, color: .gray)
                }
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
                }.buttonStyle(.borderedProminent)
                
                Button(action: {
                    appState.addToCart(product: product)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Agregar al Carrito")
                        .frame(maxWidth: .infinity)
                        .padding()


                        .cornerRadius(10)

                }.buttonStyle(.bordered)
                    .tint(.accentColor)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}


