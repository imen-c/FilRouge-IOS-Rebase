//
//  Regex.swift
//  filRouge
//
//  Created by Anthony on 01/07/2021.
//

import Foundation

enum Regex: String {
    case MAIL = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$"
    case PASSWORD = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
}
