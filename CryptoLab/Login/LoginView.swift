//
//  LoginView.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import UIKit

class LoginView: UIView{
    
    //MARK: Components
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let imageIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "CryptoLabIcon")
        img.contentMode = .scaleAspectFit
        img.heightAnchor.constraint(equalToConstant: 240).isActive = true
        img.widthAnchor.constraint(equalToConstant: 240).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return  img
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-Mail"
        tf.backgroundColor = .backgroundColor
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tf.returnKeyType = .next
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Senha"
        tf.backgroundColor = .backgroundColor
        tf.contentVerticalAlignment = .center
        tf.borderStyle = .roundedRect
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tf.autocapitalizationType = .none
        tf.returnKeyType = .done
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Entrar", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.backgroundColor = .buttonColor
        btn.setTitleColor(.textPrimary, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let errorLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .systemRed
        lb.font = .systemFont(ofSize: 20, weight: .semibold)
        lb.numberOfLines = 0
        lb.isHidden = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let togglePasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.tintColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: Init
    override init (frame: CGRect){
        super.init(frame: frame)
        setHierarchy()
        setConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Hierarchy
    private func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(imageIcon)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(errorLabel)

        passwordTextField.rightView = togglePasswordButton
        passwordTextField.rightViewMode = .always
    }
    
    //MARK: Constrains
    private func setConstrains(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40),
        ])
    }
}

#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    LoginViewController()
})
#endif
