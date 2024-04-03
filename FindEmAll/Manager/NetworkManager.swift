//
//  NetworkManager.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import UIKit

class NetworkManager {
    // networkManager 생성
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // 리턴 타입 PokemonType으로 진행
    func fetchPokemon(completion: @escaping (Pokemon?, String?) -> Void) {
        // randomPokemon check
        let pokemonIndex = Int.random(in: 1...4)
        
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
                completion(nil, "데이터는 올바르게 왔습니다만... \(error).")
            }
        }
        task.resume()
    }
    
    // 이미지를 던지는 이유는?
    func downloadImage(from dataString: String, completed: @escaping (UIImage?) -> Void) {
        
        /// cache check
        // convert String to cacheKey
        let cacheKey = NSString(string: dataString)
        
        // check if cache has image
        if let image = cache.object(forKey: cacheKey) {
            // if yes, load image
            completed(image)
            return
        }
        
        // check if URL is valid
        guard let url = URL(string: dataString) else {
            completed(nil)
            return
        }
        
        // parse url into data
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completed(nil)
                return
            }
            
            // check for error
            if let error = error {
                print("에러가 발생했습니다.")
            }
            
            // check for correct response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil)
                return
            }
            
            // check if data is correct and convert to image
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            completed(image)
        }
        task.resume()
    }
}
