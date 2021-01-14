//
//  HomeScreenViewController.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //: MARK: View Model Initialization
    var viewModel: HomeScreenViewModel = .init()
    
    // MARK: IBActions
//    @IBAction func addButtonTapped (sender: UIBarButtonItem) {
//
//        if let mapViewController = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
//
//            if let navigationViewController = self.navigationController {
//                navigationViewController.pushViewController(mapViewController, animated: true)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarItems()
        searchBar.delegate = self
        tableView.delegate = self
//        tableView.datasource = self
    }
    
    // MARK: // UI Setup Methods
    private func setupNavigationBarItems() {
        
        let help = UIImage(named: "help")
        //        let settings = UIImage(named: "settings")
        
        //        let settingsButton = self.createNavigationBarButton(selector: #selector(settingsButtonTapped(sender:)), image: settings)
        let helpButton = self.createNavigationBarButton(selector: #selector(helpButtonTapped(sender:)), image: help)
        navigationItem.rightBarButtonItems = [helpButton]
        
        
        //    @objc private func settingsButtonTapped(sender: UIBarButtonItem) {
        //
        //        // TODO: Duplicate code!
        //        if let settingsPageViewController = UIStoryboard(name: "Main", bundle: nil)
        //            .instantiateViewController(withIdentifier: "SettingsPageViewController") as? SettingsPageViewController {
        //            if let navigationViewController = self.navigationController {
        //                  navigationViewController.pushViewController(settingsPageViewController, animated: true)
        //              }
        //          }
    }
    
    @objc private func helpButtonTapped(sender: UIBarButtonItem) {
        
        if let helpPageViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "HelpPageViewController") as? HelpPageViewController {
            if let navigationViewController = self.navigationController {
                navigationViewController.pushViewController(helpPageViewController, animated: true)
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
        
        self.navigationController?.pushViewController(cityDetailsViewController, animated: true)
        
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
// TODO:

//extension HomeScreenViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return viewModel.bookmarks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//    }
//}
