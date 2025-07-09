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
                    let homeViewController = HomeViewController()
                    self?.navigationController?.setViewControllers([homeViewController], animated: true)
                } else {
                    let alert = UIAlertController(title: "Login inválido", message: "Usuário ou senha incorretos.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
