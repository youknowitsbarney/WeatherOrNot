//
//  HomeScreenViewModel.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import Foundation
import CoreLocation

class HomeScreenViewModel {
    
    // MARK: Instance Variables
    var bookmarks = [FetchCity]()
    
    // MARK: Network call methods
    func fetchCityBy(name: String, completion: @escaping (Result<FetchCity?, Error>) -> Void) {
        
        if let url = URL(string: "api.openweathermap.org/data/2.5/weather?q=Nairobi&appid=75e5b9359048652cce8409bd9a56c380") {
            
            var fetchRequest = URLRequest(url: url)
            fetchRequest.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: fetchRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                else if let data = data {
                    
                    do {
                        
                        let city = try JSONDecoder().decode(FetchCity.self, from: data)
                         // TODO: Remove
                        print(city)
                        completion(.success(city))
                        
                    } catch {
                        
                        completion(.failure(NSError(domain: "City named: \(name) not found.", code: 400, userInfo: nil)))
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchCityBy(location: CLLocation, completion: @escaping (Result<FetchCity?, Error>) -> Void) {
        
        if let url = URL(string: "") {
            
            var fetchRequest = URLRequest(url: url)
            fetchRequest.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: fetchRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                else if let data = data {
                    
                    do {
                        
                        let cities = try JSONDecoder().decode(FetchCity.self, from: data)
                        completion(.success(cities))
                        
                    } catch {
                        
                        completion(.failure(NSError(domain: "Unknown location.", code: 400, userInfo: nil)))
                    }
                }
            }
            task.resume()
        }
    }
}
