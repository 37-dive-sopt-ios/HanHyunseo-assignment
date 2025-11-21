import UIKit
import SnapKit

// MARK: - LoginViewController

class LoginViewController: UIViewController, LoginDelegate {
    
    func didLogin(with email: String) {
    }
    
    func resetLoginFields() {
        // 뒤로가기 시 입력창 초기화
        emailField.clear()
        passwordField.clear()
        refreshLoginEnabled()
        view.endEditing(true)
    }
    
    // MARK: - UI Components
    
    lazy var backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        b.tintColor = .label
        return b
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 또는 아이디로 계속"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    lazy var emailField: FloatingTextFieldView = {
        let field = FloatingTextFieldView(title: "이메일 아이디", style: .email)
        return field
    }()
    
    lazy var passwordField: FloatingTextFieldView = {
        let field = FloatingTextFieldView(title: "비밀번호", style: .password)
        return field
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("로그인", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.layer.cornerRadius = 4
        btn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        btn.isEnabled = false
        btn.backgroundColor = UIColor(named: "baemin_gray_200") ?? .systemGray2
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var findAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("계정 찾기  >", for: .normal)
        btn.setTitleColor(UIColor(named: "baemin_gray_700") ?? .secondaryLabel, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        bind()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(findAccountButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(56)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(emailField)
            make.height.equalTo(56)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailField)
        }
        
        findAccountButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        let update: (String) -> Void = { [weak self] _ in self?.refreshLoginEnabled() }
        emailField.onTextChanged = update
        passwordField.onTextChanged = update
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func refreshLoginEnabled() {
        let ok = !emailField.text.isEmpty && !passwordField.text.isEmpty
        loginButton.isEnabled = ok
        loginButton.backgroundColor = ok
        ? (UIColor(named: "baemin_mint_500") ?? .systemTeal)
        : (UIColor(named: "baemin_gray_300") ?? .systemGray3)
    }
    
    private func clearFields() {
        emailField.clear()
        passwordField.clear()
        refreshLoginEnabled()
    }
    
    // MARK: - Actions
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapLogin() {
        guard loginButton.isEnabled else { return }
        let email = emailField.text
        
        let welcomeVC = WelcomeViewController()
        welcomeVC.delegate = self
        welcomeVC.userEmail = email
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
}
