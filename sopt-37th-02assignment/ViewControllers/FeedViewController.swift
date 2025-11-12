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
    
    // MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(scrollView)
        scrollView.addSubviews(foodCategoryView, storeCategoryView)    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        foodCategoryView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(16) // 상단 여백
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            
            // 너비는 frameLayoutGuide에 맞춰 가로 스크롤 방지
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        storeCategoryView.snp.makeConstraints {
            // foodCategoryView 바로 아래에 배치합니다.
            $0.top.equalTo(foodCategoryView.snp.bottom).offset(16) // 뷰 사이의 간격
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            
            // 너비는 frameLayoutGuide에 맞춥니다.
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(16) // 하단 여백
        }
    }
}
