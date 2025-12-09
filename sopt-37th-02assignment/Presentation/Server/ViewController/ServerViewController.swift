//
//  ServerViewController.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import UIKit
import SnapKit
import Then

final class ServerViewController: UIViewController {
    
    // MARK: - Properties
    private let provider = NetworkProvider<UserAPI>()
    private var currentUserId: Int?
    
    // MARK: - UI Components (Custom Views)
    private let scrollView = UIScrollView().then { $0.keyboardDismissMode = .onDrag }
    private let contentView = UIView()
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 30
        $0.distribution = .fill
    }
    
    // 분리한 뷰들 인스턴스 생성
    private let loginView = ServerLoginView()
    private let userInfoView = UserInfoView()
    private let userUpdateView = UserUpdateView()
    private let userDeleteView = UserDeleteView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindActions()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(20) }
        
        // 스택뷰에 커스텀 뷰들 추가
        [loginView, userInfoView, userUpdateView, userDeleteView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - Binding (뷰의 이벤트와 네트워크 로직 연결)
    private func bindActions() {
        
        loginView.onLoginTapped = { [weak self] id, pw in
            self?.requestLogin(id: id, pw: pw)
        }
        
        userInfoView.onGetInfoTapped = { [weak self] in
            self?.requestGetInfo()
        }
        
        userUpdateView.onUpdateTapped = { [weak self] name, email, age in
            self?.requestUpdate(name: name, email: email, age: age)
        }
        
        userDeleteView.onDeleteTapped = { [weak self] in
            self?.requestDelete()
        }
    }
}

// MARK: - Network Logic
extension ServerViewController {
    
    private func requestLogin(id: String, pw: String) {
        let request = LoginRequest(username: id, password: pw)
        
        Task {
            do {
                let response: BaseResponse<LoginResponse> = try await provider.request(.login(request))
                
                if let data = response.data {
                    self.currentUserId = data.userId
                    self.userInfoView.updateStatus("로그인 성공! (ID: \(data.userId))\n\(data.message)", isSuccess: true)
                }
            } catch {
                self.userInfoView.updateStatus("로그인 실패", isSuccess: false)
                print(error)
            }
        }
    }
    
    private func requestGetInfo() {
        guard let uid = currentUserId else {
            userInfoView.updateStatus("로그인이 필요합니다.", isSuccess: false)
            return
        }
        
        Task {
            do {
                let response: BaseResponse<UserResponse> = try await provider.request(.getUser(id: uid))
                
                if let u = response.data {
                    let text = "[\(u.status)] \(u.username)\n이름: \(u.name)\n이메일: \(u.email)\n나이: \(u.age)세"
                    self.userInfoView.updateStatus(text, isSuccess: true)
                }
            } catch {
                self.userInfoView.updateStatus("조회 실패", isSuccess: false)
                print(error)
            }
        }
    }
    
    private func requestUpdate(name: String?, email: String?, age: Int?) {
        guard let uid = currentUserId else { return }
        let req = UpdateUserRequest(name: name, email: email, age: age)
        
        Task {
            do {
                let response: BaseResponse<UserResponse> = try await provider.request(.updateUser(id: uid, data: req))
                
                if let u = response.data {
                    self.userInfoView.updateStatus("수정 완료!\n이름: \(u.name), 이메일: \(u.email), 나이: \(u.age)", isSuccess: true)
                }
            } catch {
                self.userInfoView.updateStatus("수정 실패", isSuccess: false)
                print(error)
            }
        }
    }
    
    private func requestDelete() {
        guard let uid = currentUserId else { return }
        
        Task {
            do {
                let response: BaseResponse<String> = try await provider.request(.deleteUser(id: uid))
                
                self.userInfoView.updateStatus("탈퇴 완료: \(response.message ?? "우리 나중에 다시 만나요..꼬옥..")", isSuccess: true)
                self.currentUserId = nil
                
            } catch {
                self.userInfoView.updateStatus("탈퇴 실패", isSuccess: false)
                print(error)
            }
        }
    }
}
