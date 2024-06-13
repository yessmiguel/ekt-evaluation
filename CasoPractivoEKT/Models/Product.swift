//
//  Product.swift
//  CasoPractivoEKT
//
//  Created by Yess development on 13/06/24.
//

import Foundation

struct Product: Hashable, Codable{
    let name: String
    let category: String
    let price: Double
    let images:[String]
    
    
    
    enum CodingKeys: String, CodingKey {
            case name = "nombre"
            case category = "codigoCategoria"
            case price = "precioRegular"
            case images = "urlImagenes"
        }
}
