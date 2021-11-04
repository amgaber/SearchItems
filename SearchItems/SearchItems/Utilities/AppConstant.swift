//
//  AppConstant.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import Foundation


// API key
let kKeyAPIKey = ""

let baseUrl = "https://newsapi.org/v2"

 let query =      "?q=Apple&from=2021-11-03&sortBy=popularity&apiKey=\(kKeyAPIKey)"

//The header fields
   enum HttpHeaderField: String {
       case authentication = "Authorization"
       case contentType = "Content-Type"
       case acceptType = "Accept"
       case acceptEncoding = "Accept-Encoding"
   }
   
   //The content type (JSON)
   enum ContentType: String {
       case json = "application/json"
   }
