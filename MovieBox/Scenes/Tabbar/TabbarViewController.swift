//
//  TabbarViewController.swift
//  MovieBox
//
//  Created by Duy Nguyen on 22/3/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    private func createTabBar() {
        viewControllers = [makeHome(),
                           makeFavorite(),
                           makeSetting()]
    }
    
    private func makeHome() -> UINavigationController {
        let navVC = BaseNavigationController()
        let homeUseCase = HomeUseCase(movieRepository: MovieRepository())
        let homeNavigator = HomeNavigator(navigationController: navVC)
        let homeVM = HomeViewModel(useCase: homeUseCase, navigator: homeNavigator)
        let homeVC = HomeViewController()
        homeVC.bindViewModel(to: homeVM)
        homeVC.tabBarItem = TabbarItems.home.item
        navVC.viewControllers = [homeVC]
        return navVC
    }
    
    private func makeFavorite() -> UINavigationController {
        let navVC = BaseNavigationController()
        let favoriteUseCase = FavoriteUseCase(movieRepository: MovieRepository())
        let favoriteNavigator = FavoriteNavigator(navigationController: navVC)
        let favoriteVM = FavoriteViewModel(useCase: favoriteUseCase, navigator: favoriteNavigator)
        let favoriteVC = FavoriteViewController()
        favoriteVC.bindViewModel(to: favoriteVM)
        favoriteVC.tabBarItem = TabbarItems.favorite.item
        navVC.viewControllers = [favoriteVC]
        return navVC
    }
    
    private func makeSetting() -> UINavigationController {
        let navVC = BaseNavigationController()
        let settingUseCase = SettingUseCase()
        let settingNavigator = SettingNavigator(navigationController: navVC)
        let settingVM = SettingViewModel(useCase: settingUseCase, navigator: settingNavigator)
        let settingVC = SettingViewController()
        settingVC.bindViewModel(to: settingVM)
        settingVC.tabBarItem = TabbarItems.setting.item
        navVC.viewControllers = [settingVC]
        return navVC
    }
}
