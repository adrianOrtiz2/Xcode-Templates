//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation

struct ___VARIABLE_mainClassName___ViewModel {
    
    // MARK: - Properties
    private let repository = ___VARIABLE_mainClassName___Repository()
    typealias loginResponse = ((Bool, String?) -> ())
    
    // MARK: - Validations
    enum LoginInputsErrors {
        case EmailError
        case PasswordError
        
        func getErrorMessage() -> String {
            switch self {
            case .EmailError:
                return "Invalid e-mail"
            case .PasswordError:
                return "Invalid Password"
            }
        }
    }
    
    func validateEmail(email: String?) -> LoginInputsErrors? {
        guard let email = email,
            Utils.validateEmail(email: email) else {
                return LoginInputsErrors.EmailError
        }
        return nil
    }
    
    func validatePassword(password: String?) -> LoginInputsErrors? {
        guard let mPassword = password,
            !mPassword.isEmpty,
            !(mPassword.count < 5) else {
                return LoginInputsErrors.PasswordError
        }
        return nil
    }
    
    func login(with username: String, password: String, reponse: @escaping loginResponse) {
        repository.loginInServer(withUsername: username, password: password) { (user, error) in
            if error != nil {
                reponse(false, error)
                return
            }
            reponse(true, nil)
        }
    }

}

