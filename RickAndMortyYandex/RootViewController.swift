//
//  RootViewController.swift
//  RickAndMortyYandex
//
//  Created by Роберт Згонников on 14.06.2022.
//

import Foundation
import UIKit

final class RootViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        setUpViewControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private let mainViewController = MainViewController()
    
    private let favouriteViewController = FavouriteViewController()
    
    private var searchViewController = SearchTableViewController()
    
    private func setUpViewControllers(){
        UITabBar.appearance().tintColor = .main
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        viewControllers = [
            createNavigController(for: mainViewController, image: UIImage(named: "Home")!, selectedImage: UIImage(named: "Home_s")!),
            createNavigController(for: favouriteViewController, image: UIImage(named: "Favourite")!, selectedImage: UIImage(named: "Favourite_s")!),
            createNavigController(for: searchViewController, image: UIImage(named: "Search")!, selectedImage: UIImage(named: "Search_s")!)
        ]
        tabBar.backgroundColor = .bg
    }
    
    private func createNavigController(for rootViewController: UIViewController, image: UIImage, selectedImage: UIImage) -> UIViewController{
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.image = image
        navVC.tabBarItem.selectedImage = selectedImage
        navVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0);
        return navVC
    }
    
    private func createNavigController(for rootViewController: UIViewController, image: UIImage) -> UIViewController{
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.image = image
        navVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return navVC
    }
}
