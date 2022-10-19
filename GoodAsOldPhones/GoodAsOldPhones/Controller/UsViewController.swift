//
//  UsViewController.swift
//  GoodAsOldPhones
//
//  Created by Amirzhan Armandiyev on 18.10.2022.
//

import UIKit

class UsViewController: UIViewController {
    
    @IBOutlet weak var aboutUsInfo: UILabel!
    @IBOutlet weak var contacts: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let normalText = "Good as Old Phones returns the phones of yesteryear back to their original glory and then gets them into the hands* of those who appreciate them most:\n\n\nWhether you are looking for a turn-of-the-century wall set or a Zack Morris Special, we've got you covered. Give us a ring, and we will get you connected.\n\n\n"
        let attributedString = NSMutableAttributedString(string:normalText)
        
        let italicText = "*Hands-free phones available"
        UIFont.boldSystemFont(ofSize: 15)
        let attrs = [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 18)]
        let italicAttributedString = NSMutableAttributedString(string: italicText, attributes: attrs)
        
        attributedString.append(italicAttributedString)
        
        aboutUsInfo.attributedText = attributedString
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
