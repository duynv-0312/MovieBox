//
//  TabbarItems.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import Foundation
import UIKit

enum TabbarItems {
    case home
    case favorite
    case setting
    
    var item: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "Home",
                                image: UIImage(systemName: "house"),
                                selectedImage: UIImage(systemName: "house.fill"))
        case .favorite:
            return UITabBarItem(title: "Favorite",
                                image: UIImage(systemName: "heart"),
                                selectedImage: UIImage(systemName: "heart.fill"))
        case .setting:
            return UITabBarItem(title: "Setting",
                                image: UIImage(systemName: "gear"),
                                selectedImage: UIImage(systemName: "gear.fill"))
        }
    }
}
