//
//  Forecast.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import Foundation

// MARK: Forecast model
struct Forecast: Codable {
    
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
}

// MARK: List
struct List: Codable {
    
    let dt, pressure, seaLevel, groundLevel, humidity, visibility: Int
    let temp, feelsLike, min, max, tempKf, pop: Double
    let weather: [Weather]
    let clouds: [Clouds]
    let wind: [Wind]
    
    enum CodingKeys: String, CodingKey {
        
        case dt, temp, pressure, humidity, pop, weather, clouds, wind, visibility
        case seaLevel = "sea_level"
        case groundLevel = "ground_level"
        case min = "temp_min"
        case max = "temp_max"
        case tempKf = "temp_kf"
        case feelsLike = "feels_like"
    }
}

// MARK: City
struct City: Codable {
    
    let id, population, timezone, sunrise, sunset: Int
    let name, country: String
    let coordinates: Double
    
    enum CodingKeys: String, CodingKey {
        
        case id, population, timezone, sunrise, sunset, name, country
        case coordinates = "coord"
    }
}
