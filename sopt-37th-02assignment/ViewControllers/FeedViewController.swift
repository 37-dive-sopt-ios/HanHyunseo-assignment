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

public final class FeedViewController: UIViewController, UIScrollViewDelegate {
    
    // 1. 네비게이션 바 아이템
    private lazy var titleButton = UIButton(type: .system).then {
        $0.setTitle("우리집", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        $0.setImage(UIImage(named: "polygon1"), for: .normal)
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    // 2. 고정될 뷰
    private let headerView = HeaderView()
    
    // 3. 스크롤될 뷰
    private let scrollView = UIScrollView()
    
    // 4. 스크롤 뷰 내부의 뷰들
    private let bMartBannerView = BMartBannerView()
    private let serviceTabView = ServiceTabView()
    private let foodCategoryView = FoodCategoryView()
    private let storeCategoryView = StoreCategoryView()
    private let bannerView = BannerView()
    private let rankingView = RankingView()
    
    
    // MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setUI()
        setLayout()
        scrollView.delegate = self
    }
    
    // 뷰의 크기가 정해진 후 그라데이션 크기 설정
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Setup
    
    private func setupNav() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleButton)
        
        
        // 1. 'UIButton'으로 생성 (UIView의 자식)
        let discountButton = UIButton(type: .system).then {
            $0.setImage(UIImage(named: "discount")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        let bellButton = UIButton(type: .system).then {
            $0.setImage(UIImage(named: "alarm"), for: .normal)
            $0.tintColor = .black
        }
        
        let cartButton = UIButton(type: .system).then {
            $0.setImage(UIImage(named: "cart"), for: .normal)
            $0.tintColor = .black
        }
        let stackView = UIStackView(arrangedSubviews: [discountButton, bellButton, cartButton]).then {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 12
        }
        
        let rightBarButton = UIBarButtonItem(customView: stackView)
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setUI() {
        view.addSubviews(headerView, scrollView)
        scrollView.addSubviews(bMartBannerView, foodCategoryView, storeCategoryView, bannerView, rankingView, serviceTabView)
        
        view.backgroundColor = .baeminMint50010
        scrollView.backgroundColor = .clear
    }
    
    private func setLayout() {
        
        // 고정 뷰 (검색창)
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 스크롤 뷰 내부 콘텐츠
        
        // B마트 배너
        bMartBannerView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top) // 스크롤 뷰의 시작
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide).inset(16)
            $0.width.equalTo(scrollView.frameLayoutGuide).offset(-32) // 너비 고정
        }
        
        // ServiceTabView 레이아웃
        serviceTabView.snp.makeConstraints {
            $0.top.equalTo(bMartBannerView.snp.bottom).offset(16) // B마트 배너 아래
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // FoodCategoryView 레이아웃
        foodCategoryView.snp.makeConstraints {
            $0.top.equalTo(serviceTabView.snp.bottom)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 스토어 카테고리
        storeCategoryView.snp.makeConstraints {
            $0.top.equalTo(foodCategoryView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 광고 배너
        bannerView.snp.makeConstraints {
            $0.top.equalTo(storeCategoryView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide).inset(16)
            $0.width.equalTo(scrollView.frameLayoutGuide).offset(-32)
        }
        
        rankingView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    
}
// MARK: - UIScrollViewDelegate

extension FeedViewController {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if yOffset > 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
