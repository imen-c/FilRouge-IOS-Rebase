//
//  ViewController.swift
//  filRouge
//
//  Created by Joris Thiery on 06/05/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var mailtextfield: CustomTextField!
    @IBOutlet weak var passwordTextfield: CustomTextField!
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var bubleView: UIView!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var lblMessageFeedback: UILabel!
    
    // get a gradient for button connect
    var buttonGradient: CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = connectionButton.bounds
        // color turquoise to aquamarine need to be convert into cgColor
        gradient.colors = [UIColor.turquoise_blue.cgColor, UIColor.aquamarine.cgColor]
        return gradient
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabel()
        setupView()
        setupTextView()
        setupButton()
        
        // add notification when keyboard appear and disappear
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // need to remove keyboard notification when view termiate
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupLabel() {
        self.lblHello.text = NSLocalizedString("helloLogin", comment: "")
        self.lblHello.textColor = .pink
        
        self.lblMessageFeedback.text = ""
    }

    func setupView() {
        bottomContainerView.backgroundColor = .blueGrey
        //add a radius only for top left and top right corner
        bottomContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomContainerView.layer.cornerRadius = 40
        
        bubleView.layer.cornerRadius = 15
    }
    
    func setupButton() {
        connectionButton.setTitle(NSLocalizedString("connectCTA", comment: ""), for: .normal)
        connectionButton.setTitleColor(.white, for: .normal)
        connectionButton.backgroundColor = .clear
        connectionButton.layer.cornerRadius = 25
        connectionButton.clipsToBounds = true
        connectionButton.backgroundColor = .lightGray
        updateButtonValidity()
    }
    
    func setupTextView() {
        mailtextfield.placeholder = NSLocalizedString("emailPlaceholder", comment: "")
        mailtextfield.keyboardType = .emailAddress
        mailtextfield.delegate = self
        mailtextfield.setLeftIcon(image: UIImage(named: "icoProfilDarkblue"))
        mailtextfield.textColor = .middleBlue
        mailtextfield.layer.cornerRadius = 25
        mailtextfield.clipsToBounds = true
        mailtextfield.regex = .MAIL

        passwordTextfield.placeholder = NSLocalizedString("passwordPlaceholder", comment: "")
        passwordTextfield.keyboardType = .default
        passwordTextfield.delegate = self
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.setLeftIcon(image:UIImage(named: "icoPasswordDarkblue"))
        passwordTextfield.textColor = .middleBlue
        passwordTextfield.layer.cornerRadius = 25
        passwordTextfield.clipsToBounds = true
        passwordTextfield.regex = .PASSWORD
    }
    
    func updateButtonValidity() {
        if mailtextfield.isValid() && passwordTextfield.isValid() {
            connectionButton.layer.insertSublayer(buttonGradient, at: 0)
            connectionButton.isUserInteractionEnabled = true
        } else {
            buttonGradient.removeFromSuperlayer()
            connectionButton.isUserInteractionEnabled = false
        }
    }

    @IBAction func didTapConnection() {
        if let myTabbarController = storyboard?.instantiateViewController(identifier: "CustomTabBarController") as? CustomTabBarController {
            myTabbarController.modalPresentationStyle = .fullScreen
            present(myTabbarController, animated: true, completion: nil)
        }
    }
}

extension LoginViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        // get keyboard frame from notificcation
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            // get keyboard height
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            // update my bottom constraint to add keyboard height
            DispatchQueue.main.async {
                self.buttonBottomConstraint.constant = keyboardHeight + 30
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // update my bottom constraint to remove keyboard height
        DispatchQueue.main.async {
            self.buttonBottomConstraint.constant = 30
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {

    // when user change focus without return key on keyboard -> force call to should return to check validity
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.mailtextfield {
            let _ = textFieldShouldReturn(mailtextfield)
        } else {
            let _ = textFieldShouldReturn(passwordTextfield)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .middleBlue
        (textField as? CustomTextField)?.setRightIcon(image: nil)
        self.lblMessageFeedback.text = NSLocalizedString("loginEditing", comment: "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.mailtextfield {
            mailtextfield.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
            checkValidity(textfield: mailtextfield)
        } else {
            passwordTextfield.resignFirstResponder()
            checkValidity(textfield: passwordTextfield)
        }
        
        updateButtonValidity()
        updateTextFeedback()
        
        return true
    }
    
    func updateTextFeedback() {
        if mailtextfield.text?.isEmpty ?? false && passwordTextfield.text?.isEmpty ?? false {
            self.lblMessageFeedback.text = ""
        }
        if mailtextfield.isValid() && passwordTextfield.isValid() {
            self.lblMessageFeedback.text = NSLocalizedString("successLogin", comment: "")
        }
    }
    
    func checkValidity(textfield: CustomTextField) {
        if textfield.text?.isEmpty ?? false {
            textfield.textColor = .middleBlue
            textfield.setRightIcon(image: nil)
        } else {
            if textfield.isValid() {
                textfield.textColor = .aquamarine
                textfield.setRightIcon(image: UIImage(named: "icoCheckGreen"))
            } else {
                textfield.setRightIcon(image: UIImage(named: "icoCrossRed"))
                textfield.textColor = .coral
                
                self.lblMessageFeedback.text = NSLocalizedString("errorLogin", comment: "")
            }
        }
    }
}

