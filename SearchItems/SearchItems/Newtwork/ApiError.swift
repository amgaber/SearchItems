//
//  ApiError.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/4/21.
//

import Foundation
enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}
