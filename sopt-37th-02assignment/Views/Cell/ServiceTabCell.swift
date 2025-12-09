//
//  ServiceTabCell.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class ServiceTabCell: UICollectionViewCell {
    
    static let identifier = "ServiceTabCell"
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .baeminGray600
        $0.textAlignment = .center
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = .baeminBlack
        $0.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .baeminBlack : .baeminGray600
            titleLabel.font = isSelected ? .systemFont(ofSize: 17, weight: .bold) : .systemFont(ofSize: 17, weight: .regular)
            underlineView.isHidden = !isSelected
        }
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(underlineView)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    public func configure(with model: ServiceTabModel) {
        titleLabel.text = model.title
    }
}
