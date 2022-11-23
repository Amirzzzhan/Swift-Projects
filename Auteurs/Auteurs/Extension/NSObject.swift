//
//  NSObject.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 22.11.2022.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
