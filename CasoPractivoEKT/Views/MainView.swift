//
//  ContentView.swift
//  CasoPractivoEKT
//
//  Created by Yess development on 12/06/24.
//

import SwiftUI

struct MainView: View {
    
    @State var showProducts: Bool = false
    @State var productSelected : Product? = nil
    
    var isProductSelected : Bool {
        productSelected != nil
    }
    
    var body: some View {
        VStack(spacing: 25){
            if(isProductSelected){
                productCard
            }
            selectProductButton
        }
        .padding()
    }
    
    var productCard : some View{
        VStack(spacing: 10){
            productImage
            Text(productSelected!.name)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text(productSelected!.price.asCurrency())
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("Categoría: \(productSelected!.category)")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 30)
        }.background(
            RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .frame(maxWidth: .infinity)
            .shadow(radius: 2)
        )
    }
    
    var productImage : some View{
        VStack{
            if(productSelected!.images.count > 1){
                AsyncImage(url: URL(string: productSelected!.images.first!)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 200)
                } placeholder: {
                    imagePlaceholder
                }
                
            }else{
                imagePlaceholder
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
    
    var imagePlaceholder : some View{
        Image(systemName: "photo.stack.fill")
    }
    
    var selectProductButton: some View{
        Button {
            showProducts.toggle()
        } label: {
            Text("Seleccionar\(isProductSelected ? " otro": "") producto")
                .font(.caption)
                .bold()
                .foregroundColor(.gray)
                .padding()
                .padding(.horizontal, 10)
                .background(
                    Capsule()
                        .stroke(Color.gray, lineWidth: 2.0)
                )
        }
        .sheet(isPresented: $showProducts,
            content: {
              ProductsListView(
                selectedProduct: $productSelected
              )
        })
    }
}


#Preview {
    MainView()
}
