//
//  ProductManager.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 17/09/2022.
//

import Foundation
import Alamofire

class ProductManager{
    

    func fetchCategory(category: String, success: @escaping (PreCategory)->(), failure: @escaping (_ error:Error?) -> Void ){
        

        AF.request("\(Knetworking.categoryUrl)\(category)", headers: Knetworking.token).responseData { response in
            guard let data = response.data else {return}
            let decoder = JSONDecoder()
            
            do{
                let result = try decoder.decode(PreCategory.self, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                success(result)
                
            }catch {print(String(describing: error))}
            
        }
        
    }
    
    func fetchTopTwenty(categoryProduct: String, success: @escaping (_ categories: String) -> Void){
        
        
        AF.request("\(Knetworking.topTwentyUrl)\(categoryProduct)", headers: Knetworking.token).responseData { response in
            guard let twenty = response.data else {return}
            let decoder = JSONDecoder()

            do{
                let result = try decoder.decode(TopTwenty.self, from: twenty)
                
               let arrayID = result.content.map{($0.id)}.joined(separator: ",")
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                success(arrayID)
            
            }catch {print(String(describing: error))}
        }
        
    }
    
    func fetchDetailsProducts(Categories: String, success: @escaping ([MultigetElement]) -> Void) {
        

        AF.request("\(Knetworking.detailsProductsUrl)\(Categories)", headers: Knetworking.token).responseData { response in
            guard let data = response.data else {return}
            let decoder = JSONDecoder()
            
            do{
                let resultados = try decoder.decode(Multiget.self, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                success(resultados)
            }catch {print(String(describing: error))}
        }
        
    }
    
    func fetchProductDetails(id: String, success: @escaping (DescriptionProduct) -> Void){
        
        let url4 = "https://api.mercadolibre.com/items/\(id)/description"

        AF.request(url4, headers: Knetworking.token).responseData { response in
            guard let data = response.data else {return}
            let decoder = JSONDecoder()
            
            do{
                let resultDescription = try decoder.decode(DescriptionProduct.self, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                success(resultDescription)
            }catch {print(String(describing: error))}
        }
        
    }
        
}


