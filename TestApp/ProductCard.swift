//
//  ProductCard.swift
//  TestApp
//
//  Created by Tushar Ahmed on 17/8/24.
//

import Foundation
import SwiftUI

struct ProductCardView: View {
    var productName: String
    var price: String
    var imageName: String

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageName)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(height: 150)
            .cornerRadius(10)
            .background(Color.gray.opacity(0.2))
            Text(productName)
                .font(.headline)
                .padding(.top, 8)
            Text(price)
                .font(.subheadline)
                .foregroundColor(.gray)
            Button(action: {
            }) {
                Text("Add to Cart")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
