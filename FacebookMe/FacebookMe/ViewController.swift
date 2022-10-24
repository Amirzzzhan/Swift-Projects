//
//  ViewController.swift
//  FacebookMe
//
//  Created by Amirzhan Armandiyev on 23.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    private let texts = [["Amirzhan"], ["Friends", "Events", "Groups", "Education", "Town Hall", "Instant Games", "See More..."], ["Add Favorites..."], ["Settings", "Privacy Shortcuts", "Help and Support"], ["Log Out"]]
    private let imageNames: [[String?]] = [["bayMax"],["fb_friends", "fb_events", "fb_groups", "fb_education", "fb_town_hall", "fb_games", nil], [nil], ["fb_settings", "fb_privacy_shortcuts", "fb_help_and_support"], [nil]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Facebook"
        navigationController?.navigationBar.delegate = self
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
    }
}

extension ViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let name = texts[indexPath.section][indexPath.row]
        cell.textLabel?.text = name
        
        let icon = imageNames[indexPath.section][indexPath.row]
        if let safeIcon = icon {
            cell.imageView?.image = UIImage(named: safeIcon)
        } else {
            if(name == "Log Out") {
                cell.textLabel?.textColor = .red
                cell.textLabel?.textAlignment = .center
            } else {
                cell.imageView?.image = UIImage(named: "fb_placeholder")
                cell.textLabel?.textColor = UIColor(named: "AccentColor")
            }
        }
        
        if(indexPath.section == 0) {
            var configurations = cell.defaultContentConfiguration()
            
            configurations.image = UIImage(named: "bayMax")
            configurations.text = name
            configurations.secondaryText = "View your profile"
            
            cell.contentConfiguration = configurations
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 ? 90 : 45)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 2) {
            return "Favourites"
        } else {
            return ""
        }
    }
}

