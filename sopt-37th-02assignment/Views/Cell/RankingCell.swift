//
//  RankingCell.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/14/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class RankingCell: UICollectionViewCell {
    
    static let identifier = "RankingCell"
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let storeNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .baeminGray600
    }
    
    private let starIcon = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .systemYellow
    }
    
    private let ratingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .baeminGray600
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .baeminBlack
        $0.numberOfLines = 1 // 한 줄로 제한
    }
    
    private let discountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = UIColor(red: 255/255.0, green: 28/255.0, blue: 48/255.0, alpha: 1.0)
    }
    
    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .baeminBlack
    }
    
    private let originalPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .baeminGray600
    }
    
    private let deliveryInfoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = UIColor(red: 84/255.0,green: 21/255.0,blue: 255/255.0,alpha: 1.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(imageView, storeNameLabel, starIcon, ratingLabel, descriptionLabel, discountLabel, priceLabel, originalPriceLabel, deliveryInfoLabel)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(145)
            $0.height.equalTo(145)        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        
        starIcon.snp.makeConstraints {
            $0.centerY.equalTo(storeNameLabel)
            $0.leading.equalTo(storeNameLabel.snp.trailing).offset(4)
            $0.width.height.equalTo(14)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(storeNameLabel)
            $0.leading.equalTo(starIcon.snp.trailing).offset(2)
            $0.trailing.lessThanOrEqualToSuperview() // 오른쪽 끝을 넘지 않도록
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(discountLabel)
            $0.leading.equalTo(discountLabel.snp.trailing).offset(4)
        }
        
        originalPriceLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview()
        }
        
        deliveryInfoLabel.snp.makeConstraints {
            $0.top.equalTo(originalPriceLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
    }
    
    public func configure(with model: RankingModel) {
        imageView.image = model.storeImage
        storeNameLabel.text = model.storeName
        ratingLabel.text = model.formattedRating
        descriptionLabel.text = model.description
        discountLabel.text = "\(model.discountPercent)%"
        priceLabel.text = model.formattedPrice
        deliveryInfoLabel.text = model.deliveryInfo
        
        let attrString = NSAttributedString(
            string: model.formattedOriginalPrice,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        originalPriceLabel.attributedText = attrString
    }
}
