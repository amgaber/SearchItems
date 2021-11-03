//
//  NewData.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import Foundation

struct NewData : Decodable{
    let title:String?
    let description: String?
    let author: String?
    let source: Source?
    let content: String?
    let date: String?
    let image: String?
    let pageOfImage :String
    
    enum CodingKeys: String, CodingKey {
       case title = "title"
       case description = "description"
        case author = "author"
        case source = "source"
        case content = "content"
       case date = "publishedAt"
        case image = "urlToImage"
        case pageOfImage = "url"

      
     }
}
