//
//  LoginViewController.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    private let loginView = LoginView()
    //Aqui escolho se quero usar Firebase ou Mock:
    private let viewModel = LoginViewModel(service: SignInService())

    override func loadView() {
        view = loginView
        view.backgroundColor = .primaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(fecharTeclado))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        loginView.delegate = self
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
    
    func login() {
        viewModel.login(email: loginView.emailTextField.text ?? "", senha: loginView.passwordTextField.text ?? "") { [weak self] sucesso in
            DispatchQueue.main.async {
                if sucesso {
                    let homeViewController = HomeViewController()
                    self?.navigationController?.setViewControllers([homeViewController], animated: true)
                } else {
                    self?.loginView.configure(
                        data: LoginModel(
                            password: "",
                            email: "",
                            name: "",
                            errorLabel: "Email e senha invalido",
                            isError: true
                        )
                    )
                }
            }
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginButtonTapped() {
        self.login()
    }
}
