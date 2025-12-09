//
//  BannerModel.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit

public struct BannerModel {
    public let bannerImg: UIImage
    
    public init(bannerImg: UIImage) {
        self.bannerImg = bannerImg
    }
    
    public static let mockData: [BannerModel] = [
        BannerModel(bannerImg: UIImage(named: "banner1")!),
        BannerModel(bannerImg: UIImage(named: "banner2")!),
        BannerModel(bannerImg: UIImage(named: "banner3")!),
    ]
}
