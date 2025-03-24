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
                                image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal),
                                selectedImage: UIImage(named: "homeFill")?.withRenderingMode(.alwaysOriginal))
        case .favorite:
            return UITabBarItem(title: "Favorite",
                                image: UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal),
                                selectedImage: UIImage(named: "heartFill")?.withRenderingMode(.alwaysOriginal))
        case .setting:
            return UITabBarItem(title: "Setting",
                                image: UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal),
                                selectedImage: UIImage(named: "settingFill")?.withRenderingMode(.alwaysOriginal))
        }
    }
}
