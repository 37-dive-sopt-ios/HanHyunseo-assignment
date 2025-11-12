//
//  FeedModel.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit

public struct CategoryModel {
    public let foodCategoryImg: UIImage
    public let foodCategoryName: String
    
    public init(foodCategoryImg: UIImage, foodCategoryName: String) {
        self.foodCategoryImg = foodCategoryImg
        self.foodCategoryName = foodCategoryName
    }
    
    public static let mockData: [CategoryModel] = [
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "한그릇"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "치킨"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "카페·디저트"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "피자"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "분식"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "고기"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "찜·탕"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "야식"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "패스트푸드"),
        CategoryModel(foodCategoryImg: UIImage(named: "sheep")!, foodCategoryName: "픽업"),
    ]
    // ! 안 써서 에러
}
