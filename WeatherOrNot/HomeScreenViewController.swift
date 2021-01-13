//
//  HomeScreenViewController.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
    }
    
    // MARK: // UI Setup Methods
    private func setupNavigationBarItems() {
        
        let help = UIImage(named: "help")
        let settings = UIImage(named: "settings")
        
//        let settingsButton = self.createNavigationBarButton(selector: #selector(settingsButtonTapped(sender:)), image: settings)
        let helpButton = self.createNavigationBarButton(selector: #selector(helpButtonTapped(sender:)), image: help)
        navigationItem.rightBarButtonItems = [helpButton]
    }

//    @objc private func settingsButtonTapped(sender: UIBarButtonItem) {
//
//        // TODO: Duplicate code!
//        if let settingsPageViewController = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "SettingsPageViewController") as? SettingsPageViewController {
//            if let navigationViewController = self.navigationController {
//                  navigationViewController.pushViewController(settingsPageViewController, animated: true)
//              }
//          }
//    }
    
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

