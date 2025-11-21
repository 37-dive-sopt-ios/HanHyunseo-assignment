//
//  RankingView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/14/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class RankingView: UIView {
    
    private let data = RankingModel.mockData
    
    private let gradientLayer = CAGradientLayer().then {
        // "7276FF" (RGB: 114, 118, 255)
        let topColor = UIColor(red: 114/255.0, green: 118/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor.white.cgColor
        
        $0.colors = [topColor, bottomColor]
        $0.startPoint = CGPoint(x: 0.5, y: 0.0)
        $0.endPoint = CGPoint(x: 0.5, y: 1.0)
        $0.locations = [0.0, 0.5]
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "우리 동네 한그릇 인기 랭킹"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .baeminWhite
    }
    
    private let infoIcon = UIImageView().then {
        $0.image = UIImage(systemName: "info.circle")
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
    }
    
    private let viewAllButton = UIButton(type: .system).then {
        $0.setTitle("전체보기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.tintColor = .baeminWhite
        
        let symbolConfig = UIImage.SymbolConfiguration(
            pointSize: 10,
            weight: .medium
        )
        
        let chevronImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: symbolConfig
        )

        $0.setImage(chevronImage, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    // 컬뷰
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 260)
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(RankingCell.self, forCellWithReuseIdentifier: RankingCell.identifier)
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return cv
    }()
    
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
    
    private func setupStyle() {
        self.layer.insertSublayer(gradientLayer, at: 0)    }
    
    private func setupHierarchy() {
        self.addSubviews(titleLabel, infoIcon, viewAllButton, collectionView)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        infoIcon.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.width.height.equalTo(16)
        }
        
        viewAllButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(260)
        }
    }
}

extension RankingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCell.identifier, for: indexPath) as? RankingCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.item])
        return cell
    }
}
