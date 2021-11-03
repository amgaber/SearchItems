//
//  DataResult.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import Foundation

struct DataResult : Decodable{
    let status:String?
    let totalResults: Int?
    let articles: [NewData]?
  
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
     }
}
