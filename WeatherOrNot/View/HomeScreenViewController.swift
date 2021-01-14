//
//  HomeScreenViewController.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //: MARK: View Model Initialization
    var viewModel: HomeScreenViewModel = .init()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarItems()
        tableViewSetup()
        searchBar.delegate = self
    
    }
    
    // MARK: // UI Setup Methods
    private func setupNavigationBarItems() {
        
        let help = UIImage(named: "help")
        
        let helpButton = self.createNavigationBarButton(selector: #selector(helpButtonTapped(sender:)), image: help)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItems = [helpButton, addButton]
        
        
        
    }
    
    private func tableViewSetup() {
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cityCell")
    }
    
    @objc private func helpButtonTapped(sender: UIBarButtonItem) {
        
        if let helpPageViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "HelpPageViewController") as? HelpPageViewController {
            if let navigationViewController = self.navigationController {
                navigationViewController.pushViewController(helpPageViewController, animated: true)
            }
        }
    }
    
    @objc func addButtonTapped (sender: UIBarButtonItem) {
    
            if let mapViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
                
                mapViewController.delegate = self
    
                if let navigationViewController = self.navigationController {
                    navigationViewController.pushViewController(mapViewController, animated: true)
                }
            }
        }
    
    private func createNavigationBarButton(selector: Selector, image: UIImage?) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.layer.masksToBounds = false
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.layer.cornerRadius = 8
        button.imageView?.contentMode = .center
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .clear
        
        return UIBarButtonItem(customView: button)
    }
}



// MARK: Search Bar Delegate Methods
extension HomeScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.endEditing(true)
        
        self.viewModel.fetchCityBy(name: searchBar.text ?? "") { [weak self] (result) in
            
            switch result {
            
            case .failure:
                break // TODO: remove and set ui alert to user
            
            case .success(let city):
                
                if let city = city {
                    
                    self?.viewModel.bookmarks.append(city)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        
    }
}


// MARK: Table View Delegate Methods
extension HomeScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cityDetailsViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "CityDetailsViewController") as? CityDetailsViewController else { return }
        
        let viewModel = CityDetailsViewModel(city: (self.viewModel.bookmarks[indexPath.row]))
        
            if let navigationViewController = self.navigationController {
                cityDetailsViewController.viewModel = viewModel
                navigationViewController.pushViewController(cityDetailsViewController, animated: true)
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 175
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            viewModel.bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: Table View Data Source Methods

extension HomeScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.bookmarks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let infoCell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        let city = viewModel.bookmarks[indexPath.row]
        let tempString = String(Int(city.main.temp))

        infoCell.cityNameLabel.text = city.name
        infoCell.tempLabel.text = tempString
        infoCell.weatherDescription.text = city.weather[0].main
//        infoCell.weatherImage.image = ?
        
        return infoCell
    }
}

// MARK: Extension MapViewDelegate
extension HomeScreenViewController: MapViewDelegate {
    
    func locationSelected(location: CLLocation) {
        
        viewModel.fetchCityBy(location: location) { (result) in
            
            switch result {
            case .failure:
                // TODO: Alert
                 
                print("Failed to add from map")
                break
            
            case .success(let city):
                print(city)
                guard let city = city else { return }
                
                self.viewModel.bookmarks.append(city)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
