//
//  CountryModel.swift
//  CountriesCollectionViewLab
//
//  Created by Christian Hurtado on 1/14/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation


struct Country: Codable {
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
    let currencies: [Currency]
}

struct Currency: Codable{
    let code: String
    let name: String
    let symbol: String
}

