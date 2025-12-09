//
//  ServerLoginView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class ServerLoginView: UIView {
    
    // 외부에서 이벤트를 받을 클로저
    var onLoginTapped: ((String, String) -> Void)?
    
    private let titleLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .head_b_18
    }
    
    private let idTextField = UITextField().then {
        $0.placeholder = "아이디 (username)"
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.text = ""
    }
    
    private let pwTextField = UITextField().then {
        $0.placeholder = "비밀번호 (password)"
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
        $0.text = ""
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인 (POST)", for: .normal)
        $0.backgroundColor = .baeminMint300
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        loginButton.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, idTextField, pwTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        // 높이 제약 (TextField 등)
        [idTextField, pwTextField, loginButton].forEach {
            $0.snp.makeConstraints { $0.height.equalTo(44) }
        }
    }
    
    @objc private func tapLogin() {
        guard let id = idTextField.text, let pw = pwTextField.text else { return }
        onLoginTapped?(id, pw)
    }
}
