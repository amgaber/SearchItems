//
//  NewsListViewModel.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import Foundation
import Alamofire

struct NewsListViewModel : Decodable{
    let title:String?
    let description: String?
    let author: String?
    let source: Source?
    let content: String?
    let date: String?
    let image: String?
    let pageOfImage :String
    
    
    init(with model: NewData){
        title = model.title
        description = model.description
        author = model.author
        source = model.source
        content = model.content
        date = model.date
        image = model.image
        pageOfImage = model.pageOfImage
    }
    
    
    var pageIndex: Int = 1
    var shouldPaginate: Bool = true
    
    var items = [NewData]()
    var nextPageInfo : String = ""
    
    var itemsCount: Int {
        return items.count
    }
    
}
