//
//  UIViewController+Extension.swift
//  MovieBox
//
//  Created by Duy Nguyen on 23/3/25.
//

import Foundation
import SafariServices

extension UIViewController {
    
    func showError(error: Error) {
        switch error {
        case let AppError.normalError(message):
            self.showError(message: message)
        case AppError.noInternet:
            self.showError(title: AppError.noInternet.description)
        default:
            self.showError(message: error.localizedDescription)
        }
    }
    
    func showError(title: String = "Error", message: String = "Failed to load data") {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "OK", style: .default) { (_: UIAlertAction!) in
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true)
        }
    }
    
    func presentSafariViewController(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func showSuccess(title: String = "Success!!!!", message: String = "Completed successfully") {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
}
