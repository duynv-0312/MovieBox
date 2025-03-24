//
//  BaseViewController.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        
    }
    
    func next(ctrl: UIViewController) {
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func backToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func backToView(ctrl: UIViewController) {
        navigationController?.pushViewController(ctrl, animated: true)
    }
}
