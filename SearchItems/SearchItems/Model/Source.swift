//
//  Source.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import Foundation

struct Source : Decodable{
    let id:String?
    let name: String?
   
    
    enum CodingKeys: String, CodingKey {
       case id = "id"
       case name = "name"
     }
}

