//
//  LabTableViewCell.swift
//  StopWatch
//
//  Created by Amirzhan Armandiyev on 20.10.2022.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    @IBOutlet weak var lapCounter: UILabel!
    @IBOutlet weak var lapTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
