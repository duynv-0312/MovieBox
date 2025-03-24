//
//  Bindable.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import UIKit

public protocol Bindable: AnyObject {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
}

public extension Bindable where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModel) {
        viewModel = model
        loadViewIfNeeded()
    }
}
