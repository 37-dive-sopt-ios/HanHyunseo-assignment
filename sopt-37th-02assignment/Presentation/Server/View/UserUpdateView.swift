//
//  UserUpdateView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class UserUpdateView: UIView {
    
    // 이름, 이메일, 나이(Int?)를 전달
    var onUpdateTapped: ((String?, String?, Int?) -> Void)?
    
    private let titleLabel = UILabel().then {
        $0.text = "개인 정보 수정"
        $0.font = .head_b_18
    }
    
    private let nameField = UITextField().then { $0.placeholder = "변경할 이름"; $0.borderStyle = .roundedRect }
    private let emailField = UITextField().then { $0.placeholder = "변경할 이메일"; $0.borderStyle = .roundedRect }
    private let ageField = UITextField().then { $0.placeholder = "변경할 나이"; $0.borderStyle = .roundedRect; $0.keyboardType = .numberPad }
    
    private let updateButton = UIButton().then {
        $0.setTitle("정보 수정하기 (PATCH)", for: .normal)
        $0.backgroundColor = .baeminMint500
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        updateButton.addTarget(self, action: #selector(tapUpdate), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, nameField, emailField, ageField, updateButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        [nameField, emailField, ageField, updateButton].forEach {
            $0.snp.makeConstraints { $0.height.equalTo(44) }
        }
    }
    
    @objc private func tapUpdate() {
        let name = nameField.text?.isEmpty == false ? nameField.text : nil
        let email = emailField.text?.isEmpty == false ? emailField.text : nil
        let age = Int(ageField.text ?? "")
        
        onUpdateTapped?(name, email, age)
    }
}
