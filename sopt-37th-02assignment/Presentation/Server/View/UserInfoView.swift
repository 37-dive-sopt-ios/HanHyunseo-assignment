//
//  UserInfoView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class UserInfoView: UIView {
    
    var onGetInfoTapped: (() -> Void)?
    
    private let resultLabel = UILabel().then {
        $0.text = "로그인 상태가 아닙니다."
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = .body_r_13
        $0.textColor = .baeminGray700
        $0.backgroundColor = .baeminBackgroundWhite
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let getInfoButton = UIButton().then {
        $0.setTitle("내 정보 조회 (GET)", for: .normal)
        $0.backgroundColor = .baeminMint300
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        getInfoButton.addTarget(self, action: #selector(tapGetInfo), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [resultLabel, getInfoButton])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        resultLabel.snp.makeConstraints { $0.height.greaterThanOrEqualTo(80) }
        getInfoButton.snp.makeConstraints { $0.height.equalTo(44) }
    }
    
    @objc private func tapGetInfo() {
        onGetInfoTapped?()
    }
    
    // 외부에서 텍스트 업데이트용 메서드
    func updateStatus(_ text: String, isSuccess: Bool) {
        resultLabel.text = text
        resultLabel.textColor = isSuccess ? .black : .red
    }
}
