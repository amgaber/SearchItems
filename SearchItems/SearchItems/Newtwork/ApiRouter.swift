//
//  ApiRouter.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/4/21.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
//    q=apple&from=2020-07-12&sortBy=publishedAt&apiKey=API_ KEY
    
    case getNews( String, String, String, String)
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
          
            switch method {
               case .get:
                   return URLEncoding.default
               default:
                   return JSONEncoding.default
               }
        
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
            switch self {
            case .getNews(_, _, _, _):
                return .get
            }
        }
        
        //MARK: - Path
        //The path is the part following the base url
        private var path: String {
            switch self {
            case .getNews(_, _, _, _):
                return "everything"
            }
        }
            //MARK: - Parameters
            //This is the queries part, it's optional because an endpoint can be without parameters
            private var parameters: Parameters? {
                switch self {
                case .getNews(let query,let fromDate, let sortBy,let apiKey):
                    //A dictionary of the key (From the constants file) and its value is returned
                    return ["query" : query,
                            "fromDate" : fromDate,
                            "sortBy" : sortBy,
                            "apiKey" : apiKey
                    ]
                }
            }
        
}
