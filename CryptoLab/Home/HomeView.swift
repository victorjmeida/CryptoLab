//
//  HomeView.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 08/07/25.
//

import UIKit

class HomeView: UIView{
    
    let welcomeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy(){
        addSubview(welcomeLabel)
    }
    private func setConstrains() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
}
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    HomeViewController()
})
#endif
