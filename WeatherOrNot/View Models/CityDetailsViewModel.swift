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
        
        if let url = URL(
            string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(city.coordinates.latitude)&lon=\(city.coordinates.longitude)&cnt=5&appid=75e5b9359048652cce8409bd9a56c380&units=metric") {
            
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
            }
            task.resume()
        }
        
        
    }
}
