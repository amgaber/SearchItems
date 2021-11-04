//
//  ApiClient.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/4/21.
//

//import Alamofire
//import RxSwift

//class ApiClient {
        
//    func getNews(){
//        AF.request("https://newsapi.org/v2/everything?q=Apple&from=2021-11-03&sortBy=popularity&apiKey=\(kKeyAPIKey)").validate().responseJSON {
//                       response in
//
//                       guard response.response?.statusCode != 403 else
//                       {
//                          print("Session expired, Must relogin")
//                           return
//                       }
//                       guard response.response?.statusCode != 500 else
//                       {
//                           print("Something Went wrong, please refresh")
//                           return
//                       }
//                       guard response.response?.statusCode != 504 else
//                       {
//                           debugPrint("Gateway timeout, Please refresh")
//                           return
//                       }
//                       switch response.result {
//                       case .success:
//                          
//                               debugPrint("res:" , response.result)
//                               let res = try JSONDecoder().decode(DataResult.self, from:response.data!)
//                               debugPrint("DataResult:" , res.articles?.count)
//                            
//                               self.news = res.articles ?? []
//                               debugPrint("title:",res.articles?[1].title)
//
//                               self.newsItemCardList.reloadData()
//                          
//                       case .failure(let error):
//
//                           debugPrint(error.localizedDescription)
//                       }
//        }}
//    }
