//
//  LoginViewController.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import UIKit

class LoginViewController: UIViewController{
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()

    override func loadView() {
        view = loginView
        view.backgroundColor = .primaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc private func didTapLogin() {
        let email = loginView.emailTextField.text ?? ""
        let passWord = loginView.passwordTextField.text ?? ""
        
        viewModel.login(email: email, passWord: passWord) { [weak self] sucesso in
            DispatchQueue.main.async {
                if sucesso {
                    // Navegar
                    let alert = UIAlertController(title: "Sucesso", message: "Login bem-sucedido!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Erro", message: "Usuário ou senha inválidos.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
