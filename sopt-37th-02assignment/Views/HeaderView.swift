//
//  HeaderView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//
import Foundation
import UIKit
import SnapKit
import Then

final class HeaderView: UIView {
    
    // (컴포넌트 정의는 동일)
    private let textField = UITextField().then {
        $0.text = "찾아라! 맛있는 음식과 맛집"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .baeminGray300
    }
    
    private let searchIconView = UIImageView().then {
        $0.image = UIImage(named: "search")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Setup Methods
        
    private func setupStyle() {
        self.backgroundColor = .baeminWhite
        self.layer.cornerRadius = 22
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.baeminBlack.cgColor
    }
    
    private func setupHierarchy() {
        self.addSubview(textField)
        self.addSubview(searchIconView)

    }
    
    private func setupLayout() {
        searchIconView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        textField.snp.makeConstraints {
            $0.centerY.equalTo(searchIconView)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(searchIconView.snp.leading).offset(-8)
        }
        
    }
}
