//
//  NewsListViewModel.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import Foundation
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
}
