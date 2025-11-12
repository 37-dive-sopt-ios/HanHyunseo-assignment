import UIKit
import SnapKit

class FloatingTextFieldView: UIControl, UITextFieldDelegate {

    enum Style { case email, password }

    var text: String { textField.text ?? "" }
    var onTextChanged: ((String) -> Void)?

    private let borderDefault = UIColor(named: "baemin_gray_200") ?? .systemGray4
    private let borderActive  = UIColor.black
    private let titleColor    = UIColor(named: "baemin_gray_700") ?? .secondaryLabel
    private let iconTint      = UIColor(named: "baemin_gray_300") ?? .systemGray3

    private lazy var clearButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        b.tintColor = iconTint
        b.isHidden = true               // 텍스트가 있을 때만 보이게
        b.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        return b
    }()

    lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = borderDefault.cgColor
        view.backgroundColor = .systemBackground
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = titleColor
        label.font = normalFont
        return label
    }()

    lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.font = .systemFont(ofSize: 15)
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.delegate = self
        return field
    }()

    // 기존: eyeButton (비밀번호용)
    var eyeButton: UIButton?

    private let normalTop: CGFloat = 18
    private let floatedTop: CGFloat = 6
    private let normalFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    private let floatedFont = UIFont.systemFont(ofSize: 11, weight: .semibold)

    init(title: String, style: Style) {
        super.init(frame: .zero)
        setupUI(title: title, style: style)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(title: String, style: Style) {
        addSubview(container)
        container.snp.makeConstraints { $0.edges.equalToSuperview() }

        titleLabel.text = title
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.top.equalToSuperview().inset(normalTop)
        }

        // 공통: 클리어 버튼 먼저 추가
        container.addSubview(clearButton)

        switch style {
        case .email:
            textField.keyboardType = .emailAddress
            textField.returnKeyType = .next

            // 이메일: 클리어 버튼을 오른쪽 끝에 배치
            clearButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(8)
                make.centerY.equalToSuperview().inset(6)
                make.size.equalTo(CGSize(width: 36, height: 36))
            }

        case .password:
            textField.isSecureTextEntry = true
            textField.returnKeyType = .done

            // 비밀번호: 눈 아이콘 추가
            let eye = UIButton(type: .system)
            eye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            eye.tintColor = iconTint
            eye.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
            container.addSubview(eye)
            eye.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(8)
                make.centerY.equalToSuperview().inset(6)
                make.size.equalTo(CGSize(width: 36, height: 36))
            }
            eyeButton = eye

            // 비밀번호: 클리어 버튼은 눈 아이콘 왼쪽
            clearButton.snp.makeConstraints { make in
                make.trailing.equalTo(eye.snp.leading).offset(-4)
                make.centerY.equalToSuperview().inset(6)
                make.size.equalTo(CGSize(width: 36, height: 36))
            }
        }

        container.addSubview(textField)
        // 텍스트필드는 항상 클리어 버튼의 왼쪽까지 확장
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(clearButton.snp.leading).offset(-8)
            make.bottom.equalToSuperview().inset(10)
        }

        addTarget(self, action: #selector(becomeEditing), for: .touchUpInside)
    }

    private func bind() {
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
    }

    private func updateFloating(animated: Bool) {
        let shouldFloat = textField.isFirstResponder || !(textField.text ?? "").isEmpty
        let animations = {
            self.titleLabel.font = shouldFloat ? self.floatedFont : self.normalFont
            self.titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(shouldFloat ? self.floatedTop : self.normalTop)
            }
            self.layoutIfNeeded()
        }
        animated ? UIView.animate(withDuration: 0.18, animations: animations) : animations()
    }

    // ✅ 추가: 클리어 버튼 노출/숨김
    private func updateClearButtonVisibility() {
        let hasText = !(textField.text ?? "").isEmpty
        clearButton.isHidden = !hasText
    }

    func clear() {
        textField.text = ""
        updateFloating(animated: false)
        updateClearButtonVisibility()
    }

    @objc private func editingChanged() {
        onTextChanged?(textField.text ?? "")
        updateFloating(animated: true)
        updateClearButtonVisibility()
    }

    @objc private func editingBegan() {
        container.layer.borderColor = borderActive.cgColor
        updateFloating(animated: true)
        updateClearButtonVisibility()
    }

    @objc private func editingEnded() {
        container.layer.borderColor = borderDefault.cgColor
        updateFloating(animated: true)
        updateClearButtonVisibility()
    }

    @objc private func toggleSecure() {
        textField.isSecureTextEntry.toggle()
        eyeButton?.setImage(UIImage(systemName: textField.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)

        // 커서 위치 유지 트릭
        let isFR = textField.isFirstResponder
        let t = textField.text
        textField.text = nil
        textField.text = t
        if isFR { textField.becomeFirstResponder() }
    }

    // 추가: 텍스트 삭제 액션 (해당 필드만 클리어)
    @objc private func clearText() {
        textField.text = ""
        onTextChanged?("")               // 상위에 변경 알림 (로그인 버튼 활성화 갱신용)
        updateFloating(animated: true)
        updateClearButtonVisibility()

        // 포커스 유지(원하면 해제해도 됨)
        if !textField.isFirstResponder {
            textField.becomeFirstResponder()
        }
    }

    @objc private func becomeEditing() {
        textField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendActions(for: .editingDidEndOnExit)
        return true
    }
}

