//
//  FeedViewController.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//
import Foundation
import UIKit
import SnapKit
import Then

public final class FeedViewController: UIViewController {
    private let searchView = HeaderView()
    private let scrollView = UIScrollView()
    private let foodCategoryView = FoodCategoryView()
    private let storeCategoryView = StoreCategoryView()
    private let bannerView = BannerView()
    
    // MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setupNav()
    }
    
    private func setUI() {
        view.backgroundColor = .baeminBackgroundWhite
        view.addSubviews(searchView, scrollView)
        scrollView.addSubviews(foodCategoryView, storeCategoryView, bannerView)
    }
    
    private func setLayout() {
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(43) // 검색창 높이
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        foodCategoryView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(16)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        storeCategoryView.snp.makeConstraints {
            $0.top.equalTo(foodCategoryView.snp.bottom).offset(16)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(storeCategoryView.snp.bottom).offset(16)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing).inset(16)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width).offset(-32)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    private func setupNav() {
        
        let titleButton = UIButton(type: .system).then {
            $0.setTitle("우리집", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            $0.tintColor = .black
            $0.semanticContentAttribute = .forceRightToLeft
//            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleButton)

        let discountButton = UIBarButtonItem(
            image: UIImage.discount,
            style: .plain,
            target: self,
            action: nil
        )

        let alarmButton = UIBarButtonItem(
            image: UIImage.alarm,
            style: .plain,
            target: self,
            action: nil
        )
        let cartButton = UIBarButtonItem(
            image: UIImage.cart,
            style: .plain,
            target: self,
            action: nil
        )
        
        alarmButton.tintColor = .baeminBlack
        cartButton.tintColor = .baeminBlack
        
        self.navigationItem.rightBarButtonItems = [cartButton, alarmButton, discountButton]
    }
}
