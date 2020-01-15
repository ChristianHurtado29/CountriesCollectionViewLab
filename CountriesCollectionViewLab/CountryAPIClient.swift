//
//  CountryAPIClient.swift
//  CountriesCollectionViewLab
//
//  Created by Christian Hurtado on 1/14/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountrySearchAPI {
    
    static func getCountries(for searchQuery: String,
                              completion: @escaping (Result<[Country], AppError>) -> ()) {
            
            let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "colombia"
            
        let countryEndpointUrl = "https://restcountries.eu/rest/v2/name/\(searchQuery.lowercased())"
            
                guard let url = URL(string: countryEndpointUrl) else {
                completion(.failure(.badURL(countryEndpointUrl)))
                return
            }
            
            let request = URLRequest(url: url)
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success(let data):
                    do {
                        let searchResults = try JSONDecoder().decode([Country].self, from: data)
                        completion(.success(searchResults))
                        
                    } catch {
                        print("Error")
                    }
                }
            }
        }
    }


