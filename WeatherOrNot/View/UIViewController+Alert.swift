//
//  UIViewController+Alert.swift
//  WeatherOrNot
//
//  Created by Barney on 14/01/2021.
//

import Foundation
import UIKit


extension UIViewController {
    
    func presentAlert(title: String, message: String, style: UIAlertController.Style = .actionSheet, action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(action ?? defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
