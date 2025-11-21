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

public final class TabBarController: UITabBarController {
    // MARK: - Dependencies
    
    private let factory: ViewControllerFactory
    
    // MARK: - Init
    
    public init(factory: ViewControllerFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK: - LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    // MARK: - Setup
    
    private func setupViewControllers() {
        let feedVC = makeTabItem(
            viewController: factory.makeFeedViewController(),
            title: "홈",
            selectedImageName: "tabbarhome",
            unselectedImageName: "tabbarhome"
        )
        
        let serverVC = makeTabItem(
            viewController: factory.makeServerViewController(),
            title: "서버",
            selectedImageName: "tabbarcart",
            unselectedImageName: "tabbarcart"
        )
        
        let heartVC = makeTabItem(
            viewController: factory.makeHeartViewController(),
            title: "찜",
            selectedImageName: "tabbarheart",
            unselectedImageName: "tabbarheart"
        )
        
        let listVC = makeTabItem(
            viewController: factory.makeListViewController(),
            title: "주문내역",
            selectedImageName: "tabbarlist",
            unselectedImageName: "tabbarlist"
        )
        
        let myVC = makeTabItem(
            viewController: factory.makeMyViewController(),
            title: "마이배민",
            selectedImageName: "tabbarmy",
            unselectedImageName: "tabbarmy"
        )
        
        viewControllers = [feedVC, serverVC, heartVC, listVC, myVC]
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .baeminWhite
        appearance.shadowColor = .baeminGray200
        
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.titleTextAttributes = [
            .font: UIFont.body_r_10,
            .foregroundColor: UIColor.baeminGray700
        ]
        itemAppearance.normal.iconColor = .baeminGray700
        
        itemAppearance.selected.titleTextAttributes = [
            .font: UIFont.body_r_10,
            .foregroundColor: UIColor.baeminBlack
        ]
        itemAppearance.selected.iconColor = .baeminBlack
        
        appearance.stackedLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .baeminBlack
        tabBar.unselectedItemTintColor = .baeminGray700
    }
    
    private func makeTabItem(
        viewController: UIViewController,
        title: String,
        selectedImageName: String,
        unselectedImageName: String
    ) -> UIViewController {
        let nav = UINavigationController(rootViewController: viewController)
        
        let unselectedImage = UIImage(named: unselectedImageName)?
            .withRenderingMode(.alwaysTemplate)

        let selectedImage = UIImage(named: selectedImageName)?
            .withRenderingMode(.alwaysTemplate)

        nav.tabBarItem = UITabBarItem(
            title: title,
            image: unselectedImage,
            selectedImage: selectedImage
        )
        
        return nav
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    
    private static var lastSelectedIndex: Int = 0
    
    public func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        let isReSelected = (TabBarController.lastSelectedIndex == tabBarController.selectedIndex)
        
        if isReSelected {
            if let nav = viewController as? UINavigationController {
                nav.popToRootViewController(animated: true)
            }
        }
        
        TabBarController.lastSelectedIndex = tabBarController.selectedIndex
    }
}

// MARK: - ViewControllerFactory Protocol
public protocol ViewControllerFactory {
    func makeFeedViewController() -> UIViewController
    func makeServerViewController() -> UIViewController
    func makeHeartViewController() -> UIViewController
    func makeListViewController() -> UIViewController
    func makeMyViewController() -> UIViewController
}
