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
    
    func fetchPokemonWithId(number: Int) async throws -> Pokemon {
        
        let endPoint = baseUrl + "\(number)"
        guard let url = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(Pokemon.self, from: data)
        } catch {
            throw NetworkError.invalidDataFormat
        }
    }
    
    // Not throwing error to make no popup or
    func downloadImage(from dataString: String) async -> UIImage? {
        
        /// cache check
        // convert String to cacheKey
        let cacheKey = NSString(string: dataString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: dataString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
