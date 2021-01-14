//
//  CityDetailsViewController.swift
//  WeatherOrNot
//
//  Created by Barney on 14/01/2021.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    var viewModel: CityDetailsViewModel?

    // MARK: IB Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let city = self.viewModel?.city else { return }
        
        let sunrise = Date(timeIntervalSince1970: Double(city.sys.sunrise))
        let sunset = Date(timeIntervalSince1970: Double(city.sys.sunset))
        
        cityNameLabel.text = city.name
        sunriseLabel.text = Date.formatDate(date: sunrise)
        sunsetLabel.text = Date.formatDate(date: sunset)
//        tempLabel.text = city.
        
        tableViewSetup()
        fetchForecast()
    }
    
    private func tableViewSetup() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchForecast() {
        
        self.viewModel?.fetchWeatherForecast(completion: { (result) in
                    
                    switch result {
                    
                    case .failure(let error):
                        
                        self.presentAlert(title: "Alert", message: error.localizedDescription)
                        
                    case .success(let forecasts):
                        self.viewModel?.forecast = forecasts
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
    }
}

// MARK: Table View Delegate Methods
extension CityDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}

//MARK: Table View Data Source Methods

extension CityDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let viewModel = self.viewModel
    
        let forecast = viewModel?.forecast //Why is it nil?????
        
        return forecast?.list[0].details.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = self.viewModel,
              let forecast = viewModel.forecast,
              let forecastCell = tableView.dequeueReusableCell(withIdentifier: "dailyForecastCell", for: indexPath) as? DayForecastTableViewCell
        else { return UITableViewCell() }
        
        let keys = forecast.list[indexPath.row].details.map { $0.key }
        let values = forecast.list[indexPath.row].details.map { $0.value }

        
//        forecastCell.dayLabel =
//        forecastCell.tempLabel =
        forecastCell.humidityLabel.text = "\(keys[0]) : \(values[0])"
        forecastCell.rainLabel.text = "\(keys[1]) : \(values[1])"
        forecastCell.windLabel.text = "\(keys[2]) : \(values[2])"
            
        return forecastCell
    }
}
