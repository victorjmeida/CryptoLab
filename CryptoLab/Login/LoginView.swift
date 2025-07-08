//
//  LoginView.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import UIKit

class LoginView: UIView{
    
    let imageIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "CryptoLabIcon")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return  img
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-Mail"
        tf.backgroundColor = .backgroundColor
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Senha"
        tf.backgroundColor = .backgroundColor
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Entrar", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        btn.backgroundColor = .buttonColor
        btn.setTitleColor(.textPrimary, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setHierarchy()
        setConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy(){
        addSubview(imageIcon)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }
    
    private func setConstrains(){
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            imageIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageIcon.heightAnchor.constraint(equalToConstant: 260),
            imageIcon.widthAnchor.constraint(equalToConstant: 260),
            
            emailTextField.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 0),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 18),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 26),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    LoginViewController()
})
#endif
