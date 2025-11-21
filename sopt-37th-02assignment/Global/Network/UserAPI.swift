//
//  UserAPI.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/21/25.
//

import Foundation

// User 관련 API 엔드포인트
// Moya의 TargetType 과 비슷하게 구현함
enum UserAPI {
    case register(RegisterRequest)                      // POST /api/v1/users - 회원가입
    case login(LoginRequest)                            // POST /api/v1/auth/login - 로그인
    case getUser(id: Int)                               // GET /users/{id} - 조회
    case updateUser(id: Int, data: UpdateUserRequest)   // PATCH /users/{id} - 수정
    case deleteUser(id: Int)                            // DELETE /users/{id} - 탈퇴
}

extension UserAPI: TargetType {
    
    // 기본 URL
    public var baseURL: String {
        return Environment.baseURL
    }
    
    // API 경로
    public var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .getUser(let id):
            return "/api/v1/users/\(id)"
        case .updateUser(let id, _):
            return "/api/v1/users/\(id)"
        case .deleteUser(let id):
            return "/api/v1/users/\(id)"
            
        }
    }
    
    var method: Method {
        switch self {
        case .register:   return .post
        case .login:      return .post
        case .getUser:    return .get
        case .updateUser: return .patch
        case .deleteUser: return .delete
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .register(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)
            
        case .login(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)
            
        case .getUser, .deleteUser:
            // Body 없이 경로만 호출
            return .requestPlain
            
        case .updateUser(_, let data):
            // 수정할 데이터만 Body에 담음 (ID는 경로에 있음)
            return .requestJSONEncodable(data)
        }
    }
    
    // 헤더 (Moya와 동일 - 필요시 오버라이드)
    public var headers: [String: String]? {
        // Content-Type은 Task에서 자동 설정되므로 여기서는 nil 반환
        return nil
    }
}
