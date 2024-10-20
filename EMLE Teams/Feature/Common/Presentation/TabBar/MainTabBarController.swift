//
//  MainTabBarController.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import SwiftUI
import EMLECore

class MainTabBarController: UITabBarController, TabBarControllerProtocol {
    
    var tabBarItems: [TabBarItem] = []
    
    var selectedTabItem: TabBarItem? {
        didSet {
            if let selectedTabItem {
                selectedIndex = tabBarItems.firstIndex(of: selectedTabItem) ?? 0
            }
            else {
                selectedIndex = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboard = TabBarItem(title: "Dashboard",
                                   image: .dashboard,
                                   viewControllerProvider: getDashboardViewController)
        
        TabBarItem.dashboard = dashboard
        
        let finance = TabBarItem(title: "Finanace",
                                 image: .finance,
                                 viewControllerProvider: getFinanceViewController)
        
        TabBarItem.finance = finance
        
        let myLibrary = TabBarItem(title: "My Library",
                                    image: .myLibrary,
                                    viewControllerProvider: getMyLibraryViewController)
        
        TabBarItem.library = myLibrary
        
        let more = TabBarItem(title: "More",
                              image: .more,
                              viewControllerProvider: getMoreViewController)
        
        TabBarItem.more = more
        
        tabBarItems = [dashboard, finance, myLibrary, more]
        
        configure()
    }
}

extension MainTabBarController {
    
    private func getDashboardViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let coordinator = DashboardViewCoordinator(navigationController: navigationController,
                                                   tabBarController: self)
        let view = DashboardView(coordinator: coordinator)
        
        let viewController = UIHostingController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        return navigationController
    }
    
    private func getFinanceViewController() -> UIViewController {
        let navigationController = UINavigationController()
        
        let coordinator = FinanceViewCoordinator(navigationController: navigationController, tabBarController: self)
        
        let view = FinanceView(coordinator: coordinator)
        
        let viewController = UIHostingController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        return navigationController
    }
    
    private func getMyLibraryViewController() -> UIViewController {
        let navigationController = UINavigationController()
        
        let coordinator = LibarayViewCoordinator(navigationController: navigationController, tabBarController: self)
        
        let view = LibraryView(coordinator: coordinator)
        
        let viewController = UIHostingController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        return navigationController
    }
    
    private func getMoreViewController() -> UIViewController {
        let navigationController = UINavigationController()
        
                let coordinator = MoreCoordinator(navigationController: navigationController,tabBarController: self)
                let view = MoreView(coordinator: coordinator)
        let viewController = UIHostingController(rootView: view)
        
        navigationController.setViewControllers([viewController], animated: false)
        
        return navigationController
    }
}
