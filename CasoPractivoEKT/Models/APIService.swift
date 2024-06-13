//
//  APIService.swift
//  CasoPractivoEKT
//
//  Created by Yess development on 13/06/24.
//

import Foundation

class APIService{
    func getProducts() async throws -> [Product]{
////        throw MyError.runtimeError("some message")
//        return [
//            Product(
//                name: "Motorola Moto G9 Play 64 GB Azul Eléctrico + Audífonos",
//                category: "C",
//                price: 2300, 
//                images: ["https://elektraqa.vteximg.com.br/arquivos/ids/1140189/31042911.jpg?v=637461696481900000"]
//            ),
//            Product(
//                name: "S - Motorola Moto G9 Play 64 GB Azul Eléctrico + Audífonos",
//                category: "C",
//                price: 2300,
//                images: ["https://elektraqa.vteximg.com.br/arquivos/ids/1140189/31042911.jpg?v=637461696481900000"]
//            )
//        ]
        
        let endpoint = "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a"
        guard let url = URL(string: endpoint) else { throw URLError(URLError.Code.badURL) }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw URLError(URLError.Code.dataNotAllowed)
        }
        
        do{
            let decoder = JSONDecoder()
            let result = try decoder.decode(Response.self, from: data)
            return result.resultado.productos;
        }catch{
            throw URLError(URLError.Code.cannotParseResponse)
        }
        
        
        
    }
}


struct Response: Decodable {
    let resultado: Result
}


struct Result: Decodable{
    let productos: [Product]
}


enum MyError: Error {
    case runtimeError(String)
}
