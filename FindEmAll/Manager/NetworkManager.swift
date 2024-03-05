//
//  NetworkManager.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

class NetworkManager {
    // networkManager 생성
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // 리턴 타입 PokemonType으로 진행
    func fetchPokemon(completion: @escaping (Pokemon?, String?) -> Void) {
        // randomPokemon check
        let pokemonIndex = Int.random(in: 1...151)
        
        // basePoint
        let endPoint = baseUrl + "\(pokemonIndex)"
        
        // url이 있는지 확인 (endpoint)
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
                let pokemonData = try decoder.decode(Pokemon.self, from: data)
                completion(pokemonData, nil)
            } catch {
                completion(nil, "데이터는 올바르게 왔지만 문제가 발생했습니다.")
            }
        }
        task.resume()
    }
    
    func cacheData(from urlString: String, completion: @escaping (Pokemon) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        
    }
}
