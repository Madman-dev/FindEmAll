//
//  NetworkManager.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

//class NetworkManager {
//    static let shared = NetworkManager()
//    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
//    var randomNum = Int.random(in: 1...151)
//    let decoder = JSONDecoder()
//    
//    private init() { }
//    
//    
//    
//    private func fetchData(completed: @escaping (Result<Pokemon, Error>) -> Void) {
//        // URL 정보 - endpoint
//        let endpoint = baseURL + "\(randomNum)"
//        
//        // endpoint가 있는지 확인
//        guard let url = URL(string: endpoint) else { return }
//        
//        // 특정 정보 호출 - specific
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            // 각 데이터 처리
//            // 오류 처리
//            if let error = error {
//                print("데이터 파싱 오류 발생")
//            }
//            
//            // response 처리
//            if let fetchedResponse = response as? HTTPURLResponse, fetchedResponse.statusCode != 200 {
//                print("데이터 호출 오류 발생")
//            }
//            
//            guard let data = data else {
//                // 데이터 파싱 오류 처리
//                return
//            }
//            
//            // 데이터 처리
//            do {
//                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let pokemon = try self.decoder.decode([Pokemon].self, from: data)
//            } catch {
//                print("데이터 처리에 오류가 발생했습니다.")
//            }
//        }
//    }
//}


class NetworkManager {
    // networkManager 생성
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // 리턴 타입 PokemonType으로 진행
    func fetchData(for pokemon: Int, completion: @escaping ([Pokemon]?, String?) -> Void) {
        // basePoint
        let endPoint = baseUrl + "\(pokemon)"
        
        // url이 있는지 확인 (endpoint)
        let url = URL(string: baseUrl) // 가드문으로 정리하는구나
        guard let url = URL(string: endPoint) else {
            completion(nil, "없는 URL입니다.")
            return
        }
        
        // task 생성 - data, response, error 처리
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let _ = error {
                completion(nil, "데이터 호출 오류가 발생했습니다.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "서버에서 받은 데이터에 오류가 있습니다.")
                return
            }
            
            guard let data = data else {
                completion(nil, "데이터 파싱이 잘못되었습니다.")
                return
            }
            
            do {
                // 받아온 데이터 decode
                let pokemonData = try decoder.decode([Pokemon].self, from: data)
                completion(pokemonData, nil)
            } catch {
                completion(nil, "데이터는 올바르게 왔지만 문제가 발생했습니다.")
            }
        }
        task.resume()
    }
}
