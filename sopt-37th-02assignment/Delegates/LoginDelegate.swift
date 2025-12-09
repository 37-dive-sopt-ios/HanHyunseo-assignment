import Foundation

protocol LoginDelegate: AnyObject {
    func didLogin(with email: String)
    func resetLoginFields() // 로그인 입력 초기화
}
