//
//  ProductRowView.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

