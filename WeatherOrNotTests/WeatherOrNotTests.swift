//
//  WeatherOrNotUnitTests.swift
//  WeatherOrNotTests
//
//  Created by Barney on 14/01/2021.
//

import CoreLocation
import XCTest

class WeatherOrNotUnitTests: XCTestCase {

    let location = CLLocation(latitude: 108, longitude: 210)
    
    var viewModel = HomeScreenViewModel()
    var cityViewModel: CityDetailsViewModel?
    
    override func setUp() {
        
        viewModel.fetchCityBy(location: location) { (result) in
            switch result {
            case .failure: XCTFail()
                
            case .success(let city):
                
                if let city = city {
                    
                    self.cityViewModel = CityDetailsViewModel(city: city)
                    self.viewModel.bookmarks.append(city)
                }
            }
        }
    }
    
    func testDidFetchCity() {
        
        XCTAssertEqual(self.viewModel.bookmarks.count, 1)
    }
    
    func testDidFetchCityWithName() {
        
        viewModel.fetchCityBy(name: "London") { (result) in
            
            switch result {
            
            case .failure: XCTFail()
                
            case .success:
                XCTAssertEqual(self.viewModel.bookmarks.count, 1)
            }
        }
    }
    
    func testDidFetchWeatherForecast() {
        guard let vm = cityViewModel else {
            XCTFail()
            return
        }
        cityViewModel?.fetchWeatherForecast(completion: { (result) in
            
            switch result {
            
            case .failure:
                XCTAssertEqual(vm.forecast?.city.id, nil)
                
            case .success(let forecast):
                XCTAssertEqual(vm.forecast?.city.id, forecast?.city.id)
            }
        })
    }

}
