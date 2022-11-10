//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 06.11.2022.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    let taskLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Adding all subviews
    private func addSubviews() {
        contentView.addSubview(taskLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(dateLabel)
    }
    
    // MARK: - Setting layout constraints programmatically
    private func configureConstraints() {
        NSLayoutConstraint.activate(
            [addressLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             addressLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             addressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
             addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
             addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
             
             taskLabel.trailingAnchor.constraint(equalTo: addressLabel.leadingAnchor, constant: -10),
             taskLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             taskLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
             taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
             taskLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
             
             dateLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 10),
             dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
             dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
             dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ]
        )
    }
}
