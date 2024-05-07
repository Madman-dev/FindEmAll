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
    func fetchPokemon() async throws -> Pokemon {
        // randomPokemon check
        let pokemonIndex = Int.random(in: PokemonGenerationEnum.firstGen)
        let endPoint = baseUrl + "\(pokemonIndex)"
        
        // async takes care using throw
        guard let url = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }
        
        // async doesn't require data, response, error type - it removes errors to the end.
        // do try catch는 error 또는 실제 값을 받은 이후 처리하는 과정
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        // take care of final piece of data
        do {
            return try decoder.decode(Pokemon.self, from: data)
        } catch {
            throw NetworkError.invalidDataFormat
        }
    }
    
    func fetchPokemonWithId(number: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        let endPoint = baseUrl + "\(number)"
        guard let url = URL(string: endPoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            // check to maintain weak reference to self.
            guard let self = self else { return }
            
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
                let pokemonData = try decoder.decode(Pokemon.self, from: data)
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
            if let _ = error {
                print(NetworkError.networkError)
                return
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
