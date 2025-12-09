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
    
    // 네비게이션 바 아이템
    private lazy var titleButton = UIButton(type: .system).then {
        $0.setTitle("우리집", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        $0.setImage(UIImage(named: "polygon1"), for: .normal)
        $0.tintColor = .black
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    // 고정될 뷰
    private let headerView = HeaderView()
    
    // 스크롤될 뷰
    private let scrollView = UIScrollView()
    
    // 스크롤 뷰 내부의 뷰들
    private let bMartBannerView = BMartBannerView()
    private let serviceTabView = ServiceTabView()
    
    // 스와이프 될 뷰
    private lazy var pageContentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        cv.delegate = self
        cv.dataSource = self
        
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "pageCell")
        
        return cv
    }()
    
    // 스와이프 아래에 고정될 뷰
    private let storeCategoryView = StoreCategoryView()
    private let bannerView = BannerView()
    private let rankingView = RankingView()
    
    // 스와이프될 뷰의 내용
    private let foodCategoryView = FoodCategoryView()
    private let pickupView = UIView().then {
        $0.backgroundColor = .baeminWhite
    }
    private let shoppingView = UIView().then {
        $0.backgroundColor = .baeminWhite
    }
    private let festaView = UIView().then {
        $0.backgroundColor = .baeminWhite
    }
    private let giftView = UIView().then {
        $0.backgroundColor = .baeminWhite
    }
    private let allView = UIView().then {
        $0.backgroundColor = .baeminWhite
    }
    
    // 페이지 뷰들을 배열로 관리
    private lazy var pages: [UIView] = [foodCategoryView, pickupView, shoppingView, festaView, giftView, allView]
    
    // 탭
    private let serviceTabItems = ServiceTabModel.mockData
    
    
    // MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setUI()
        setLayout()
        scrollView.delegate = self
        setupServiceTabHandler()
    }
    
    // MARK: - Setup
    
    private func setupNav() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleButton)
        
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
        scrollView.addSubviews(bMartBannerView, serviceTabView, pageContentCollectionView, storeCategoryView, bannerView, rankingView)
        
        view.backgroundColor = .baeminBackgroundWhite
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
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // ServiceTabView 레이아웃
        serviceTabView.snp.makeConstraints {
            $0.top.equalTo(bMartBannerView.snp.bottom).offset(-20)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // PageContentCollectionView 레이아웃
        pageContentCollectionView.snp.makeConstraints {
            $0.top.equalTo(serviceTabView.snp.bottom)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(235)
        }
        
        // 스토어 카테고리
        storeCategoryView.snp.makeConstraints {
            $0.top.equalTo(pageContentCollectionView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 광고 배너
        bannerView.snp.makeConstraints {
            $0.top.equalTo(storeCategoryView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 인기 랭킹
        rankingView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(16)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 메인 스크롤뷰에만 적용
        guard scrollView == self.scrollView else { return }
        
        let yOffset = scrollView.contentOffset.y
        
        if yOffset > 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    // 페이지 스와이프 -> 탭 선택
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // pageContentCollectionView에만 적용
        guard scrollView == pageContentCollectionView else { return }
        
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        self.serviceTabView.selectTab(at: indexPath)
    }
}

// MARK: - 탭 - 페이지 연동 로직
extension FeedViewController {
    
    // 탭 클릭 → 페이지 이동
    private func setupServiceTabHandler() {
        serviceTabView.onTabSelected = { [weak self] index in
            guard let self = self else { return }
            let indexPath = IndexPath(item: index, section: 0)
            
            self.pageContentCollectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true
            )
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceTabItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath)
        
        // 셀을 재사용할 때 기존 뷰를 제거
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // 페이지 배열에서 뷰를 가져와 셀에 추가
        if indexPath.item < pages.count {
            let pageView = pages[indexPath.item]
            cell.contentView.addSubview(pageView)
            pageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        
        return cell
    }
    
    // 셀(페이지)의 크기를 CollectionView 프레임과 동일하게 설정
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
