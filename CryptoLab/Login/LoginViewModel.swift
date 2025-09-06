//
//  LoginViewModel.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import Foundation

enum LoginValidationError: Error {
    case camposVazios
    case emailInvalido
    case senhaVazia
}

// Depence Injector
final class LoginViewModel {
    
    private let service: SignInServiceProtocol
    
    init(service: SignInServiceProtocol){
        self.service = service
    }
    
    //Lógica do Login
    func login(email: String, senha: String, completion: @escaping (Bool) -> Void) {
        service.registerUserFirebase(email: email, password: senha) { result in
            switch result {
            case .success(let value):
                print("Login \(value)")
                completion(true)
            case .failure(let error):
                print("Erro \(error)")
                completion(false)
            }
        }
    }
    
}
