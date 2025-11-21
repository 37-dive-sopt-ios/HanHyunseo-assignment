//
//  AppFactory.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit

final class AppFactory: ViewControllerFactory {
    func makeFeedViewController() -> UIViewController {
        return FeedViewController()
    }

    func makeServerViewController() -> UIViewController {
        return ServerViewController()
    }

    func makeHeartViewController() -> UIViewController {
        return HeartViewController()
    }

    func makeListViewController() -> UIViewController {
        return ListViewController()
    }

    func makeMyViewController() -> UIViewController {
        return MyViewController()
    }
}
