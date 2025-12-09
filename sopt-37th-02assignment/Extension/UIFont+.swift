//
//  UIFont+.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit

enum PretendardWeight: String {
    case regular = "Regular"
    case semibold = "SemiBold"
    case bold = "Bold"

    var systemWeight: UIFont.Weight {
        switch self {
        case .regular:  return .regular
        case .semibold: return .semibold
        case .bold:     return .bold
        }
    }
}

extension UIFont {
    static func pretendard(_ weight: PretendardWeight = .regular, size: CGFloat) -> UIFont {
        let name = "Pretendard-\(weight.rawValue)"
        if let custom = UIFont(name: name, size: size) {
            return custom
        }
        return .systemFont(ofSize: size, weight: weight.systemWeight)
    }

    enum Pretendard {
        case head_b_24
        case head_b_18
        case head_b_16
        case head_b_14
        case head_b_13
        
        case title_sb_18
        case title_sb_14
        case title_sb_12
        
        case body_r_14
        case body_r_13
        case body_r_12
        case body_r_10

        var weight: PretendardWeight {
            switch self {
            case .head_b_24, .head_b_18, .head_b_16, .head_b_14, .head_b_13:
                return .bold
            case .title_sb_18, .title_sb_14, .title_sb_12:
                return .semibold
            case .body_r_14, .body_r_13, .body_r_12, .body_r_10:
                return .regular
            }
        }

        var size: CGFloat {
            switch self {
            case .head_b_24: return 24
            case .head_b_18, .title_sb_18: return 18
            case .head_b_16: return 16
            case .head_b_14, .title_sb_14, .body_r_14: return 14
            case .head_b_13, .body_r_13: return 13
            case .title_sb_12, .body_r_12: return 12
            case .body_r_10: return 10
            }
        }

        var font: UIFont {
            .pretendard(weight, size: size)
        }

        var letterSpacingPercent: CGFloat {
            switch self {
            case .head_b_24, .head_b_18, .head_b_16:
                return -2.0
            case .head_b_14:
                return -4.0
            case .head_b_13:
                return -6.0
            case .title_sb_18:
                return -3.0
            case .title_sb_14:
                return -4.0
            case .title_sb_12:
                return 0.0
            case .body_r_14, .body_r_10:
                return -4.0
            case .body_r_13, .body_r_12:
                return -3.0
            }
        }

        var lineHeightPercent: CGFloat {
            return 100.0
        }
    }

    // MARK: - Static Accessors

    static var head_b_24: UIFont { Pretendard.head_b_24.font }
    static var head_b_18: UIFont { Pretendard.head_b_18.font }
    static var head_b_16: UIFont { Pretendard.head_b_16.font }
    static var head_b_14: UIFont { Pretendard.head_b_14.font }
    static var head_b_13: UIFont { Pretendard.head_b_13.font }
    
    static var title_sb_18: UIFont { Pretendard.title_sb_18.font }
    static var title_sb_14: UIFont { Pretendard.title_sb_14.font }
    static var title_sb_12: UIFont { Pretendard.title_sb_12.font }
    
    static var body_r_14: UIFont { Pretendard.body_r_14.font }
    static var body_r_13: UIFont { Pretendard.body_r_13.font }
    static var body_r_12: UIFont { Pretendard.body_r_12.font }
    static var body_r_10: UIFont { Pretendard.body_r_10.font }
}
