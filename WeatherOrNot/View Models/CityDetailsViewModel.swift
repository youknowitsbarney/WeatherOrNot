//
//  CityDetailsViewModel.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import Foundation

class CityDetailsViewModel {
    
    let city: FetchCity
    var forecast: Forecast?
    
    init(city: FetchCity) {
        
        self.city = city
    }
    
    func fetchWeatherForecast(completion: @escaping (Result<Forecast?, Error>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        if let url = URL(
            string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(city.coordinates.longitude)&lon=\(city.coordinates.latitude)&cnt=5&appid=c6e381d8c7ff98f0fee43775817cf6ad") {
            
            dispatchGroup.enter()
            var fetchRequest = URLRequest(url: url)
            fetchRequest.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: fetchRequest) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                else if let data = data {
                    let forecast = try? JSONDecoder().decode(Forecast.self, from: data)
                    self.forecast = forecast
                    completion(.success(forecast))
                }
                dispatchGroup.leave()
            }
            task.resume()
        }
        
        
    }
}
