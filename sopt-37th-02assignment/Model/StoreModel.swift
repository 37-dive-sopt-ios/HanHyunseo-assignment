//
//  StoreModel.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit

public struct StoreModel {
    public let storeCategoryImg: UIImage
    public let storeCategoryName: String
    
    public init(storeCategoryImg: UIImage, storeCategoryName: String) {
        self.storeCategoryImg = storeCategoryImg
        self.storeCategoryName = storeCategoryName
    }
    
    public static let mockData: [StoreModel] = [
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "B마트"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "CU"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "이마트슈퍼"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "홈플러스"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "GS25"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "이마트"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "컬리"),
        StoreModel(storeCategoryImg: UIImage(named: "sheep")!, storeCategoryName: "쿠팡프레쉬"),
    ]
}
