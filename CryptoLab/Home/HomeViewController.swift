//
//  HomeViewController.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 08/07/25.
//

import UIKit

class HomeViewController: UIViewController{
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
        homeView.backgroundColor = .backgroundColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
