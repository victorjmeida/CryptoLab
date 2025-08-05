//
//  LoginViewModel.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 04/07/25.
//

import Foundation
import FirebaseAuth

enum LoginValidationError: Error {
    case camposVazios
    case emailInvalido
    case senhaVazia
}

class LoginViewModel{
    //Validaçao dos campos e E-Mail
    func validar(email: String, senha: String) -> LoginValidationError? {
        if email.isEmpty {
            return .emailInvalido
        }
        if senha.isEmpty {
            return .senhaVazia
        }
        if !LoginViewModel.emailValido(email) {
            return .emailInvalido
        }
        return nil
    }
    
    //Lógica do Login
    func login(email: String, senha: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: senha) { result, error in
            guard let error = error else {
                print("Error ao fazer login")
                completion(false)
                return
            }
            completion(true)
        }
    }

    //Validaçao de formato E-Mail
    private static func emailValido(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
