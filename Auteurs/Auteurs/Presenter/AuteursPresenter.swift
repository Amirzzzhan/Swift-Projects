//
//  AuteursPresenter.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 22.11.2022.
//

import Foundation

typealias presenterDelegate = AuteursPresenterDelegate & MainVC

protocol AuteursPresenterDelegate: AnyObject {
    func presentAuteurs(auteurs: [Auteurs])
}

final class AuteursPresenter {
    
    private weak var delegate: presenterDelegate?
    
    func getAuteurs() {
        guard let url = Bundle.main.url(forResource: "Auteurs", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let jsonData = try JSONDecoder().decode(ResponseData.self, from: data)
            
            self.delegate?.presentAuteurs(auteurs: jsonData.auteurs)
            
        } catch {
            print(error)
        }
    }
    
    func setDelegate(delegate: presenterDelegate) {
        self.delegate = delegate
    }
}
