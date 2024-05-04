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
    
    // 리턴 타입 PokemonType으로 진행µ
    func fetchPokemon(completion: @escaping (Result<Pokemon, Error>) -> Void) {
        // randomPokemon check
        let pokemonIndex = Int.random(in: 1...4)
        
        // basePoint
        let endPoint = baseUrl + "\(pokemonIndex)"
        
        // url이 있는지 확인 (endpoint)
        guard let url = URL(string: endPoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // task 생성 - data, response, error 처리
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(NetworkError.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataReturned))
                return
            }
            
            do {
                let pokemonData = try self.decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonData))
            } catch {
                completion(.failure(NetworkError.invalidDataFormat))
            }
        }
        task.resume()
    }
    
    func fetchPokemonWithId(number: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        // basePoint
        let endPoint = baseUrl + "\(number)"
        
        // url이 있는지 확인 (endpoint)
        guard let url = URL(string: endPoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // task 생성 - data, response, error 처리
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(NetworkError.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataReturned))
                return
            }
            
            do {
                // 받아온 데이터 decode
                let pokemonData = try self.decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonData))
            } catch {
                completion(.failure(NetworkError.invalidDataFormat))
            }
        }
        task.resume()
    }
    
    // 이미지를 던지는 이유는?
    func downloadImage(from dataString: String, completed: @escaping (Result<UIImage, Error>) -> Void) {
        
        /// cache check
        // convert String to cacheKey
        let cacheKey = NSString(string: dataString)
        
        // check if cache has image
        if let image = cache.object(forKey: cacheKey) {
            // if yes, load image
            completed(.success(image))
            return
        }
        
        // check if URL is valid
        guard let url = URL(string: dataString) else {
            completed(.failure(NetworkError.invalidURL))
            return
        }
        
        // parse url into data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // check for error
            if let error = error {
                print("에러가 발생했습니다.")
            }
            
            // check for correct response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(NetworkError.invalidResponse))
                return
            }
            
            // check if data is correct and convert to image
            guard let data = data, let image = UIImage(data: data) else {
                completed(.failure(NetworkError.invalidDataFormat))
                return
            }
            completed(.success(image))
        }
        task.resume()
    }
}
