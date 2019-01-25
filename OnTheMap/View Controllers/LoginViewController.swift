//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 7/17/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    var keyboardOnScreen = true
    var appDelegate: AppDelegate!
    var userKey = ""
    
    
    // Mark: Outlets
    
    @IBOutlet var udacityImageView: UIView!
    @IBOutlet weak var loginToUdacityLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        let app = UIApplication.shared
        app.open(URL(string: "https://www.udacity.com")!)
    }
    
    // Mark: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
        subscribeToNotification(UIResponder.keyboardDidShowNotification, selector: #selector(keyboardDidShow))
        subscribeToNotification(UIResponder.keyboardDidHideNotification, selector: #selector(keyboardDidHide))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugTextLabel.text = ""
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    
    func completeLogin(_ sender: Any) {
        performUIUpdatesOnMain {
            self.debugTextLabel.text = ""
            self.setUIEnabled(true)
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ManagerNavigationController") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        userDidTapView(self)
        
        setUIEnabled(false)
        UdacityClient.sharedInstance().authenticateUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [unowned self] (result, error) in
            self.setUIEnabled(true)
            
            if let error = error {
                self.loginFailure(error)
                
            } else {
                
                if let _ = result {
                    self.getUserInfo()
                    
                    
                }
            }
        }
    }
}



extension LoginViewController {
    
    func loginFailure(_ error: NSError) {
        let alert = UIAlertController(title: "\(error.localizedDescription)", message: "The request failed", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    func getUserInfo(){
        UdacityClient.sharedInstance().getPublicUserData { [unowned self] (data, error) in
            if let error = error {
                print(error)
            } else {
                if let data = data {
                    self.completeLogin(data)
                }
            }
        }
    }
}


// Mark: - LoginViewController: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    // Mark: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Mark: Show/Hide Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if keyboardOnScreen {
            //view.frame.origin.y -= keyboardHeight(notification)
            //udacityImageView.isHidden = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if !keyboardOnScreen {
            view.frame.origin.y = 0
            //view.frame.origin.y += keyboardHeight(notification)
            udacityImageView.isHidden = false
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        keyboardOnScreen = true
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func userDidTapView(_ sender: AnyObject) {
        resignIfFirstResponder(emailTextField)
        resignIfFirstResponder(passwordTextField)
    }
}

// Mark: - LoginViewController (Notifications)

private extension LoginViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}


// Mark: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        
        performUIUpdatesOnMain {
            self.emailTextField.isEnabled = enabled
            self.passwordTextField.isEnabled = enabled
            self.logInButton.isEnabled = enabled
            self.debugTextLabel.text = ""
            self.debugTextLabel.isEnabled = enabled
            
            
            self.logInButton.alpha = enabled ? 1.0 : 0.5
            
        }
        
    }
}


// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, and mentors

