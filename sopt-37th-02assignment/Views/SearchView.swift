//
//  SearchView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class SearchView: UIView {
    private let placeholderLabel = UILabel().then {
        $0.text = "찾아라! 맛있는 음식과 맛집"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .baeminGray300
    }
    
    private let searchIconView = UIImageView().then {
        $0.image = UIImage.search
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupStyle() {
        self.backgroundColor = .baeminWhite
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(named: "baemin_black")?.cgColor
    }
    
    private func setupHierarchy() {
        self.addSubview(placeholderLabel)
        self.addSubview(searchIconView)
    }
    
    private func setupLayout() {
        // 돋보기 아이콘 (오른쪽)
        searchIconView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24) // 아이콘 크기
        }
        
        // 플레이스홀더 레이블 (왼쪽)
        placeholderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(searchIconView.snp.leading).offset(-8)
        }
    }
}
