//
//  NetworkError.swift
//  FindEmAll
//
//  Created by Porori on 3/26/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case networkError // possibility of error being 'timeout' for URLSession
    case noDataReturned
    case invalidDataFormat // possibility of data structure being different.
}
