//
//  LoginViewController.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import UIKit

class LoginViewController: UIViewController{
    
    private let loginView = LoginView()

    override func loadView() {
        view = loginView
        view.backgroundColor = .primaryColor
    }
}
