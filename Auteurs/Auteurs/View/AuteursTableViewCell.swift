//
//  AuteursTableViewCell.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 22.11.2022.
//

import UIKit

final class AuteursTableViewCell: UITableViewCell {
    
    // MARK: - UI
    let auteursPhoto: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill

        return image
    }()
    
    let nameText: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.backgroundColor = UIColor(named: "Black")
        text.font = UIFont.systemFont(ofSize: 16.0)
        text.textAlignment = .center
        
        return text
    }()
    
    let bioText: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        text.backgroundColor = UIColor(named: "Black")
        text.font = UIFont.systemFont(ofSize: 16.0)
        text.numberOfLines = 0
        
        return text
    }()
    
    let sourceText: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        text.backgroundColor = UIColor(named: "Black")
        text.font = UIFont.systemFont(ofSize: 14.0)
        text.numberOfLines = 0
        
        return text
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let padding = 8.0
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        contentView.backgroundColor = UIColor(named: "Black")
        
        contentView.addSubview(auteursPhoto)
        contentView.addSubview(nameText)
        contentView.addSubview(bioText)
        contentView.addSubview(sourceText)
    }
    
    // MARK: - Configure Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [auteursPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
             auteursPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    
             nameText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
             nameText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
             nameText.topAnchor.constraint(equalTo: auteursPhoto.bottomAnchor, constant: Constants.padding),
             
             bioText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: Constants.padding),
             bioText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
             bioText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
             
             sourceText.topAnchor.constraint(equalTo: bioText.bottomAnchor, constant: Constants.padding),
             sourceText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
             sourceText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
             sourceText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2 * Constants.padding)
            ]
        )
    }
}
