//
//  MainView.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @State private var query: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar productos...", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        appState.searchProducts(query: query)
                    }
                
                Button(action: {
                    appState.searchProducts(query: query)
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Buscar")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                
                if appState.isLoading {
                    ProgressView("Buscando productos...")
                        .padding()
                }
                
                if let errorMessage = appState.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                if !appState.searchResults.isEmpty {
                    List(appState.searchResults) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRowView(product: product)
                        }
                    }
                    .refreshable {
                        let previousResults = appState.searchResults.count
                        appState.searchProducts(query: query)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if appState.searchResults.count == previousResults {
                                appState.errorMessage = "No hay nuevos resultados para \"\(query)\"."
                            }
                        }
                    }
                    
                    
                } else if !query.isEmpty && !appState.isLoading {
                    Text("No hay resultados para \"\(query)\"")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Buscar")
            .toolbar {
                //                ToolbarItem(placement: .principal) {
                //                    HStack {
                //                        Text("MeliSearch")
                //                            .font(.headline)
                //                        Text("ByMercadoLibre")
                //                            .font(.caption)
                //
                //                    }
                //                }
                NavigationLink(destination: CartView()) {
                    ZStack {
                        Image(systemName: "cart")
                            .font(.title2)
                        
                        if !appState.cart.isEmpty {
                            Text("\(appState.cart.count)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }
                    }
                }
            }
            
        }
    }
}
