//
//  Network.swift
//  NewsCase
//
//  Created by burak ozen on 20.02.2022.
//

import Foundation
import Alamofire

class Network{
    
    static func getNewsData(query: String, complationHandler:@escaping (NewsResponse)->(), errorHandler:@escaping (String)->()){
        AF.request("https://newsapi.org/v2/everything?q=\(query)&page=1&apiKey=e8727d49d8c64dfdbb8dedff168cb185").responseDecodable { (response:AFDataResponse<NewsResponse>) in
            switch response.result{
                case .success(let newsResponse):
                complationHandler(newsResponse)
                break
                case .failure(let error):
                errorHandler(error.localizedDescription)
                    print(error)
                break
            }
        }
    }
    
}

