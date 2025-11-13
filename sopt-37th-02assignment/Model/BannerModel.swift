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
        BannerModel(bannerImg: UIImage(named: "divesoptios37hanhyunseo")!),
        BannerModel(bannerImg: UIImage(named: "sheep")!),
        BannerModel(bannerImg: UIImage(named: "sheep")!),
        BannerModel(bannerImg: UIImage(named: "sheep")!),
    ]
}
