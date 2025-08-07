//
//  LoginViewService.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 05/08/25.
//

import Foundation
import FirebaseAuth

protocol SignInServiceProtocol {
    func registerUserFirebase(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}

//Chama FireBase
final class SignInService: SignInServiceProtocol {
    func registerUserFirebase(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error ao fazer login")
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                completion(.success(user))
            }
        }
    }
}

//Mock
final class SignInServiceMock: SignInServiceProtocol {
    var isError: Bool

    init(isError: Bool = false) {
        self.isError = isError
    }

    func registerUserFirebase(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.isError {
                let error = NSError(
                    domain: "com.mock.login",
                    code: 401,
                    userInfo: [NSLocalizedDescriptionKey: "Login Inválido (MOCK)."]
                )
                completion(.failure(error))
            } else {
                completion(.failure(NSError(domain: "com.mock.user", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock de sucesso - não há User real!"])))
            }
        }
    }
}
    
struct DummyUser {}
