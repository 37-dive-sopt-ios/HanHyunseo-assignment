//
//  CategoryCell.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class FoodCategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private let foodCategoryImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    // MARK: - Init (추가)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods (추가)
    override func prepareForReuse() {
        super.prepareForReuse()
        foodCategoryImageView.image = nil
        nameLabel.text = nil
    }
    
    // MARK: - Setup Methods (추가)
    
    private func setupHierarchy() {
        contentView.addSubview(foodCategoryImageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupLayout() {
        foodCategoryImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(foodCategoryImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Public Method (추가)
    public func configure(with model: CategoryModel) {
        foodCategoryImageView.image = model.foodCategoryImg
        nameLabel.text = model.foodCategoryName
    }
}
