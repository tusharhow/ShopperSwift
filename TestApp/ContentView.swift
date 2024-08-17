//
//  ContentView.swift
//  TestApp
//
//  Created by Tushar Ahmed on 12/8/24.
//




import SwiftUI
import Combine



// MARK: - ViewModel
class ProductViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProducts() {
        isLoading = true
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Product].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }, receiveValue: { products in
                self.products = products
            })
            .store(in: &cancellables)
    }
}



// MARK: - Content View
struct ContentView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Shopper")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "cart.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .padding()

                HStack {
                    TextField("Search products", text: .constant(""))
                        .padding(.leading, 24)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(viewModel.products) { product in
                                ProductCardView(
                                    productName: product.title,
                                    price: String(format: "$%.2f", product.price),
                                    imageName: product.image
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
