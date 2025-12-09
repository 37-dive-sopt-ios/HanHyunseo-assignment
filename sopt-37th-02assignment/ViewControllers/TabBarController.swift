//
//  TabBarController.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupStyle()
    }
    
    private func setupUI() {
        let homeVC = FeedViewController()
        let navHome = UINavigationController(rootViewController: homeVC)
        navHome.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "tabbarhome"),
            selectedImage: UIImage(named: "tabbarhome"),
        )
        
        let shoppingVC = UIViewController()
        shoppingVC.view.backgroundColor = .baeminMint300
        shoppingVC.tabBarItem = UITabBarItem(
            title: "장보기·쇼핑",
            image: UIImage(named: "tabbarcart"),
            selectedImage: UIImage(named: "tabbarcart")
        )
        
        let wishlistVC = UIViewController()
        wishlistVC.view.backgroundColor = .baeminMint500
        wishlistVC.tabBarItem = UITabBarItem(
            title: "찜",
            image: UIImage(named: "tabbarheart"),
            selectedImage: UIImage(named: "tabbarheart")
        )
        
        let orderVC = UIViewController()
        orderVC.view.backgroundColor = .baeminMint300
        orderVC.tabBarItem = UITabBarItem(
            title: "주문내역",
            image: UIImage(named: "tabbarlist"),
            selectedImage: UIImage(named: "tabbarlist")
        )
        
        let myBaeminVC = UIViewController()
        myBaeminVC.view.backgroundColor = .baeminMint500
        myBaeminVC.tabBarItem = UITabBarItem(
            title: "마이배민",
            image: UIImage(named: "tabbarmy"),
            selectedImage: UIImage(named: "tabbarmy")
        )
        
        self.viewControllers = [navHome, shoppingVC, wishlistVC, orderVC, myBaeminVC]
    }
    
    private func setupStyle() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .baeminGray700
    }
}
