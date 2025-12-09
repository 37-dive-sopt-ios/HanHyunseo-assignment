//
//  ServiceTabModel.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation

struct ServiceTabModel {
    let title: String
    
    static let mockData: [ServiceTabModel] = [
        ServiceTabModel(title: "음식배달"),
        ServiceTabModel(title: "픽업"),
        ServiceTabModel(title: "장보기·쇼핑"),
        ServiceTabModel(title: "배민푸드페스타"),
        ServiceTabModel(title: "선물하기"),
        ServiceTabModel(title: "혜택모아보기"),
    ]
}
