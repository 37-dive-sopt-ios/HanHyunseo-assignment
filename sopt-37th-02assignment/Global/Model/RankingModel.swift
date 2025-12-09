//
//  RankingModel.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/14/25.
//

import Foundation
import UIKit

struct RankingModel {
    let storeName: String
    let rating: Double
    let reviewCount: Int
    let description: String
    let discountPercent: Int
    let price: Int
    let originalPrice: Int
    let deliveryInfo: String
    let storeImage: UIImage
    
    // "5.0 (1,973)" 형식
    var formattedRating: String {
        return "\(rating) (\(reviewCount.formatted()))"
    }
    
    // "12,000원" 형식
    var formattedPrice: String {
        return "\(price.formatted())원"
    }
    
    // "16,000원" 형식
    var formattedOriginalPrice: String {
        return "\(originalPrice.formatted())원"
    }
    
    static let mockData: [RankingModel] = [
        RankingModel(storeName: "백억보쌈제육...", rating: 5.0, reviewCount: 1973, description: "[든든한 한끼] 보쌈 막국수", discountPercent: 25, price: 12000, originalPrice: 16000, deliveryInfo: "최소주문금액 없음", storeImage: UIImage(named: "rank1")!),
        RankingModel(storeName: "명진핏짜피자...", rating: 5.0, reviewCount: 1973, description: "(1인) 피자 + 사이드 Set", discountPercent: 20, price: 12000, originalPrice: 15000, deliveryInfo: "최소주문금액 없음", storeImage: UIImage(named: "rank2")!),
        RankingModel(storeName: "혜연불닭발...", rating: 5.0, reviewCount: 1973, description: "[인기] 닭발 세트", discountPercent: 25, price: 12000, originalPrice: 16000, deliveryInfo: "최소주문금액 없음", storeImage: UIImage(named: "rank3")!),
        RankingModel(storeName: "수민춘천닭갈비...", rating: 5.0, reviewCount: 1973, description: "닭갈비 1인정식 (볶음밥 포함)", discountPercent: 25, price: 12000, originalPrice: 16000, deliveryInfo: "최소주문금액 없음", storeImage: UIImage(named: "rank4")!),
        RankingModel(storeName: "승준이네치킨...", rating: 5.0, reviewCount: 1973, description: "후라이드+양념 반반", discountPercent: 25, price: 12000, originalPrice: 16000, deliveryInfo: "최소주문금액 없음", storeImage: UIImage(named: "rank5")!),
    ]
}

// (헬퍼) 1000 -> 1,000 변환
extension Int {
    func formatted() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
