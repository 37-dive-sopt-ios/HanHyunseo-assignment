//
//  BMartBannerView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class BMartBannerView: UIView {
    
    // MARK: - UI Components
    
    private let imageView = UIImageView().then {
        $0.image = .bMartImg
        $0.contentMode = .left
    }
    
    private let descriptionButton = UIButton().then {
        $0.configuration = .plain()
        
        var titleAttr = AttributedString("전상품 쿠폰팩 + 60%특가")
        titleAttr.font = .systemFont(ofSize: 16, weight: .bold)
        $0.configuration?.attributedTitle = titleAttr
        
        let symbolConfig = UIImage.SymbolConfiguration(
            pointSize: 10,
            weight: .bold
        )
        
        let chevronImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: symbolConfig
        )
        
        $0.configuration?.image = chevronImage
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.imagePadding = 2
        
        $0.configuration?.baseForegroundColor = .darkGray
        $0.isUserInteractionEnabled = false
        $0.configuration?.contentInsets = .zero
    }
    
    private let gradientLayer = CAGradientLayer()
    
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
        gradientLayer.frame = self.bounds
    }
    
    // MARK: - Setup Methods
    
    private func setupStyle() {
        self.clipsToBounds = true
        
        gradientLayer.colors = [
            UIColor.baeminMint300.cgColor,
            UIColor.baeminBackgroundWhite.cgColor,
            UIColor.baeminBackgroundWhite.cgColor
        ]
        
        gradientLayer.locations = [0.0, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.3, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.3, y: 0.0)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupHierarchy() {
        self.addSubview(imageView)
        self.addSubview(descriptionButton)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        
        descriptionButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.equalTo(imageView)
            $0.bottom.equalToSuperview().inset(42)
        }
    }
}
