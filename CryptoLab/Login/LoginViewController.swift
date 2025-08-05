//
//  LoginViewController.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()

    override func loadView() {
        view = loginView
        view.backgroundColor = .primaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginView.togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(fecharTeclado))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func didTapLogin() {
        let email = loginView.emailTextField.text ?? ""
        let senha = loginView.passwordTextField.text ?? ""
        
        if let error = viewModel.validar(email: email, senha: senha) {
            switch error {
            case .camposVazios:
                loginView.errorLabel.text = "Preencha todos os campos."
                loginView.errorLabel.isHidden = false
                loginView.emailTextField.becomeFirstResponder()
            case .emailInvalido:
                loginView.errorLabel.text = "Digite um e-mail válido."
                loginView.errorLabel.isHidden = false
                loginView.emailTextField.becomeFirstResponder()
            case .senhaVazia:
                loginView.errorLabel.text = "Digite a senha."
                loginView.errorLabel.isHidden = false
                loginView.passwordTextField.becomeFirstResponder()
            }
            return
        }
        
        loginView.errorLabel.isHidden = true
        loginView.loginButton.isEnabled = false
        loginView.activityIndicator.startAnimating()
        
        viewModel.login(email: email, senha: senha) { [weak self] sucesso in
            DispatchQueue.main.async {
                
                self?.loginView.activityIndicator.stopAnimating()
                self?.loginView.loginButton.isEnabled = true
                
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
    
    @objc private func togglePasswordVisibility() {
        loginView.passwordTextField.isSecureTextEntry.toggle()
        let eyeIconName = loginView.passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        loginView.togglePasswordButton.setImage(UIImage(systemName: eyeIconName), for: .normal)
    }
    
    @objc private func fecharTeclado() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let scrollView = (view as? LoginView)?.scrollView {
            let frame = textField.convert(textField.bounds, to: scrollView)
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailTextField {
            loginView.passwordTextField.becomeFirstResponder()
        } else if textField == loginView.passwordTextField {
            textField.resignFirstResponder()
            didTapLogin()
        }
        return true
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottomInset = keyboardFrame.height + 40 //Valor da subida do teclado
        if let scrollView = (view as? LoginView)?.scrollView {
            scrollView.contentInset.bottom = bottomInset
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        if let scrollView = (view as? LoginView)?.scrollView {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        }
    }
}
