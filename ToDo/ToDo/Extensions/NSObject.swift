//
//  NSObject.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 10.11.2022.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
