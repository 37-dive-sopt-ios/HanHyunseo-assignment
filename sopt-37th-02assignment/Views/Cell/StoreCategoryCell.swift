//
//  StoreCategoryCell.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit

final class StoreCategoryCell: UICollectionViewCell {
    static let identifier = "StoreCategoryCell"
    
    private let imageView = UIImageView().then{
        $0.backgroundColor = .baeminWhite
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .baeminGray600
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    private func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.width) // 1:1 비율
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public func configure(with model: StoreModel) {
        imageView.image = model.storeCategoryImg
        nameLabel.text = model.storeCategoryName
    }
}
