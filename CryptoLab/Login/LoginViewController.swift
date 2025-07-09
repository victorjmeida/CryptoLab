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
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc private func didTapLogin() {
        let email = loginView.emailTextField.text ?? ""
        let senha = loginView.passwordTextField.text ?? ""
        
        if let error = viewModel.validar(email: email, senha: senha) {
            // Mostra mensagem específica de erro
            switch error {
            case .camposVazios:
                loginView.errorLabel.text = "Preencha todos os campos."
            case .emailInvalido:
                loginView.errorLabel.text = "Digite um e-mail válido."
            }
            loginView.errorLabel.isHidden = false
            return
        }
        
        loginView.errorLabel.isHidden = true
        viewModel.login(email: email, senha: senha) { [weak self] sucesso in
            DispatchQueue.main.async {
                if sucesso {
                    let homeViewController = HomeViewController()
                    self?.navigationController?.setViewControllers([homeViewController], animated: true)
                } else {
                    self?.loginView.errorLabel.text = "E-Mail ou senha inválidos."
                    self?.loginView.errorLabel.isHidden = false
                }
            }
        }
    }
}
