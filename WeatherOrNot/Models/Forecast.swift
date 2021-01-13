//
//  Forecast.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import Foundation

// MARK: Forecast model
struct Forecast {
    
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
}

// MARK: List
struct List {
    
    let dt, pressure, seaLevel, groundLevel, humidity, visibility: Int
    let temp, feelsLike, min, max, temp_kf, pop: Double
    let weather: [Weather]
    let clouds: [Clouds]
    let wind: [Wind]
    
    
}

// MARK: City
struct City: Codable {
    
    let id, population, timezone, sunrise, sunset: Int
    let name, country: String
}
