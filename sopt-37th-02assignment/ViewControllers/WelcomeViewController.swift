import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    weak var delegate: LoginDelegate?
    var userEmail: String = ""
    
    lazy var backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        b.tintColor = .label
        return b
    }()
    
    lazy var headLabel: UILabel = {
        let label = UILabel()
        label.text = "대체 뼈찜 누가 시켰어??"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    lazy var welcomeImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "welcome"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var backBottomButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("메인으로 가기", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(named: "baemin_mint_500") ?? .systemTeal
        b.layer.cornerRadius = 4
        b.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return b
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        emailLabel.text = "\(userEmail)님\n반가워요"
        
        layout()
        bind()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(backButton)
        view.addSubview(headLabel)
        view.addSubview(welcomeImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(emailLabel)
        view.addSubview(backBottomButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        headLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        welcomeImageView.contentMode = .scaleAspectFill
        welcomeImageView.clipsToBounds = true
        
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(0)
        }
        
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
        }
        
        backBottomButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        backBottomButton.addTarget(self, action: #selector(gotoMain), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc private func gotoMain() {
        let feedVC = TabBarController()
        navigationController?.pushViewController(feedVC, animated: true)
    }
}
