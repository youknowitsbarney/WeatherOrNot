//
//  HomeScreenVC+UISearchBarDelegate.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import UIKit

extension HomeScreenViewController: UISearchBarDelegate {

    
    private func searchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.endEditing(true)
        
        
        self.viewModel?.fetchCityBy(name: searchBar.text ?? "") { [weak self] (result) in
            
            switch result {
            
            case .failure:
                break // TODO: remove and set ui alert to user
            
            case .success(let city):
                
                if let city = city {
                    
                    self?.viewModel?.bookmarks.append(city)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        
    }
}
