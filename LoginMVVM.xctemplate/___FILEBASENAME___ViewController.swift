//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

class ___VARIABLE_mainClassName___ViewController: UIViewController, KeyboardProtocol {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    private let viewModel = ___VARIABLE_mainClassName___ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Life cycle

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerKeyBoardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyBoardNotifications()
    }
    
    // MARK: - Actions
    
    @IBAction func doLogin(_ sender: Any) {
        loginValidations()
    }
    
    // MARK: - Methods
    
    private func loginValidations() {
        self.view.endEditing(true)
        
        if let errorEmail = viewModel.validateEmail(email: username.text) {
            // Display error message
            print(errorEmail.getErrorMessage())
            return
        }
        if let errorPassword = viewModel.validatePassword(password: password.text) {
            // Display error message
            print(errorPassword.getErrorMessage())
            return
        }
        loginInServer()
    }
    
    private func loginInServer() {

        viewModel.login(with: username.text!, password: password.text!, reponse: { (success, error) in
            if success {
                // Login Success
            } else {
                // Error login
            }
        })
    }
    
    /*
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ___VARIABLE_mainClassName___ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == username {
            password.becomeFirstResponder()
        } else {
            loginValidations()
        }
        return true
    }
    
}
