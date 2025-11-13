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
    private let scrollView = UIScrollView()
    private let foodCategoryView = FoodCategoryView()
    private let storeCategoryView = StoreCategoryView()
    private let bannerView = BannerView()
    
    // MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(scrollView)
        scrollView.addSubviews(foodCategoryView, storeCategoryView, bannerView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
}
