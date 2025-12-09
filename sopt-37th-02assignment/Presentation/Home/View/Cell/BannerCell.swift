//
//  BannerCell.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    private let bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill // 이미지가 꽉 차도록
        $0.clipsToBounds = true
    }
    
    // MARK: - Init
    override init (frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    public func configure(with model: BannerModel) {
        bannerImageView.image = model.bannerImg
    }
}
