//
//  ProductsListView.swift
//  CasoPractivoEKT
//
//  Created by Yess development on 13/06/24.
//

import SwiftUI

struct ProductsListView: View {
    
    @Binding var selectedProduct: Product?
    @Environment(\.presentationMode) var presentationMode
    
    @State var products: [Product] = []
    @State var loading: Bool = false
    @State var errorMessage: String = ""

    
    var body: some View {
        NavigationView{
            VStack{
                if(loading){
                    loadingView
                }else if(!errorMessage.isEmpty){
                    errorView
                }else{
                    listView
                }
            }
            .navigationTitle("Productos disponibles")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            getProducts()
        }
    }
    
    var errorView: some View{
        VStack(alignment: .center){
            Text(errorMessage)
            Button("Cargar de nuevo") {
                 getProducts()
            }
        }
    }
    
    var loadingView: some View{
        VStack(alignment: .center){
            Text("Cargando productos")
            ProgressView()
        }
    }
    
    var listView: some View{
        List{
            Section {
                ForEach(products, id: \.self) { product in
                    ProductRow(product: product, onSelect: {
                        selectedProduct = product
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            } header: {
                Text("Selecciona un producto para ver su detalle")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    func getProducts() {
        Task {
            do{
                loading = true
                products = try await APIService().getProducts()
                loading = false
            }catch{
                errorMessage = "Error al cargar los productos"
                loading = false
            }
        }
    }
}


struct ProductRow: View {
    let product: Product
    let onSelect: (() -> Void)?
    
    var body: some View {
        Button(
            action: onSelect ?? {},
            label: {
                HStack{
                    productImage
                    Text(product.name)
                        .font(.callout)
                    Text(product.price.asCurrency())
                        .font(.subheadline)
                        .bold()
                        .frame(minWidth: 100, maxWidth: 100)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        )
        .foregroundColor(.black)
    }
    
    var productImage : some View{
        VStack{
            if(product.images.count > 1){
                AsyncImage(url: URL(string: product.images.first!)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 40)
                } placeholder: {
                    Image(systemName: "photo.stack.fill")
                }
                
            }else{
                Image(systemName: "photo.stack.fill")
            }
        }
        .frame(minWidth: 60, maxWidth: 60, minHeight: 40)
    }
}


//#Preview {
//    ProductsListView(nil)
//}
