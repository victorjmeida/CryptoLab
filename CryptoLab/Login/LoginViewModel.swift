//
//  LoginViewModel.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import Foundation

class LoginViewModel{
    func login(email: String, passWord: String, completion: @escaping(Bool) -> Void ) {
        if email == "teste@gmail.com" && passWord == "123456" {
            completion(true)
        }else {
            completion(false)
        }
    }
}
