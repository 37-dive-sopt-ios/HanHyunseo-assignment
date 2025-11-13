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
            image: UIImage(systemName: "house"), // 기본 아이콘
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let shoppingVC = UIViewController()
        shoppingVC.view.backgroundColor = .baeminMint300
        shoppingVC.tabBarItem = UITabBarItem(
            title: "장보기·쇼핑",
            image: UIImage(systemName: "bag"),
            selectedImage: UIImage(systemName: "bag.fill")
        )
        
        let wishlistVC = UIViewController()
        wishlistVC.view.backgroundColor = .baeminMint500
        wishlistVC.tabBarItem = UITabBarItem(
            title: "찜",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        let orderVC = UIViewController()
        orderVC.view.backgroundColor = .baeminMint300
        orderVC.tabBarItem = UITabBarItem(
            title: "주문내역",
            image: UIImage(systemName: "doc.text"),
            selectedImage: UIImage(systemName: "doc.text.fill")
        )
        
        let myBaeminVC = UIViewController()
        myBaeminVC.view.backgroundColor = .baeminMint500
        myBaeminVC.tabBarItem = UITabBarItem(
            title: "마이배민",
            image: UIImage(systemName: "smiley"),
            selectedImage: UIImage(systemName: "smiley.fill")
        )
        
        self.viewControllers = [navHome, shoppingVC, wishlistVC, orderVC, myBaeminVC]
    }
    
    private func setupStyle() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .baeminGray700
    }
}
