//
//  FilmTableViewCell.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 23.11.2022.
//

import UIKit

final class FilmTableViewCell: UITableViewCell {
    
    // MARK: - UI
    let filmsPhoto: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.setContentHuggingPriority(UILayoutPriority.init(rawValue: 252), for: .vertical)
        image.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 1000), for: .vertical)
        
        return image
    }()
    
    let filmsName: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.backgroundColor = UIColor(named: "Black")
        text.font = UIFont.boldSystemFont(ofSize: 17.0)
        text.textAlignment = .center
        text.setContentHuggingPriority(UILayoutPriority.init(rawValue: 252), for: .vertical)
        text.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 1000), for: .vertical)
        
        return text
    }()
    
    let moreInfoText: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .red
        text.backgroundColor = UIColor(named: "Black")
        text.font = UIFont.systemFont(ofSize: 17.0)
        text.textAlignment = .center
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
        static let padding = 25.0
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        contentView.backgroundColor = UIColor(named: "Black")
        
        contentView.addSubview(filmsPhoto)
        contentView.addSubview(filmsName)
        contentView.addSubview(moreInfoText)
    }
    
    // MARK: - Configure Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [filmsPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
             filmsPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             
             filmsName.topAnchor.constraint(equalTo: filmsPhoto.bottomAnchor, constant: Constants.padding / 2),
             filmsName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             filmsName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             
             moreInfoText.topAnchor.constraint(equalTo: filmsName.bottomAnchor, constant: Constants.padding / 2),
             moreInfoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
             moreInfoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
             moreInfoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding)
            ]
        )
    }
    
}
