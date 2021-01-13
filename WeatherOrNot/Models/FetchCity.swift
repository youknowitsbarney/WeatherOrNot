//
//  FetchCity.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import Foundation

//MARK: Fetch single city response

struct FetchCity: Codable {
    
    let coord: Coordinates
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

//MARK: Coordinates
struct Coordinates: Codable {
    
    let longitude, latitude: Double
}

// MARK: Weather
struct Weather: Codable {
    
    let id: Int
    let main, description: String
    let icon: String
}

// MARK: Main
struct Main: Codable {
    
    let temp, feelsLike, min, max: Double
    let pressure, humidity: Int
}

// MARK: Wind
struct Wind: Codable {
    
    let speed: Double
    let degrees: Int
}

// MARK: Clouds
struct Clouds: Codable  {
    
    let all: Int
}

// MARK: Sys
struct Sys: Codable {
    
    let type, id, sunrise, sunset: Int
    let country: String
}
