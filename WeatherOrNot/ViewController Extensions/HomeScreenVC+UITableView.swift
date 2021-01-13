//
//  HomeScreenVC+UITableView.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import Foundation
import UIKit

extension HomeScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cityDetailsViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "CityDetailsViewController") as? CityDetailsViewController else { return }
        
        let viewModel = CityDetailsViewModel(city: (self.viewModel?.bookmarks[indexPath.row])!)
        
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
            
            viewModel?.bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

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
