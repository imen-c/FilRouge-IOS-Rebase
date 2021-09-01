//
//  CustomTextField.swift
//  filRouge
//
//  Created by Anthony on 01/07/2021.
//

import UIKit

class CustomTextField: UITextField  {
    var regex: Regex? = nil
    
    func isValid() -> Bool {
        if !(self.text?.isEmpty ?? true) {
            if let regex = regex {
                return NSPredicate(format: "SELF MATCHES %@", regex.rawValue).evaluate(with: self.text)
            } else {
                return true
            }
        }
        
        return false
    }
    
    func setLeftIcon(image: UIImage?) {
        if let image = image {
            let icon = UIImageView(frame: CGRect(x: 20, y: 16, width: 18, height: 18))
            icon.image = image
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.height))
            container.addSubview(icon)
            
            leftView = container
            leftViewMode = .always
        } else {
            leftView = nil
        }
    }
    
    func setRightIcon(image: UIImage?) {
        if let image = image {
            let icon = UIImageView(frame: CGRect(x: 7, y: 16, width: 18, height: 18))
            icon.image = image
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.height))
            container.addSubview(icon)
            
            rightView = container
            rightViewMode = .always
        } else {
            rightView = nil
        }
    }
}
