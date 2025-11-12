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
    private let categoryView = CategoryView()
    
    // MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(scrollView)
        scrollView.addSubviews(categoryView)
    }

    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
            
        categoryView.snp.makeConstraints {
            // 1. contentLayoutGuide의 4방향에 모두 연결
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            
            // 2. 너비는 frameLayoutGuide에 맞춰 가로 스크롤 방지
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
    }
}
