//
//  UserDeleteView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class UserDeleteView: UIView {
    
    var onDeleteTapped: (() -> Void)?
    
    private let deleteButton = UIButton().then {
        $0.setTitle("회원 탈퇴 (DELETE)", for: .normal)
        $0.backgroundColor = .baeminGray800
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        deleteButton.addTarget(self, action: #selector(tapDelete), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
    
    @objc private func tapDelete() {
        onDeleteTapped?()
    }
}
