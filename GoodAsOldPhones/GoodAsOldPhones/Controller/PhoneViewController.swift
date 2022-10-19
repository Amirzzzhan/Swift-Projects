//
//  PhoneViewController.swift
//  GoodAsOldPhones
//
//  Created by Amirzhan Armandiyev on 18.10.2022.
//

import UIKit

class PhoneViewController: UIViewController {
    
    var phone: Phone?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Learn AutoLayout Programmatically
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        label.center = CGPoint(x: view.center.x, y: 200)
        label.textAlignment = .center
        label.text = phone?.phoneName
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 25)
        self.view.addSubview(label)
        
        let addToCardImage = UIImage(named: "AddToCard")
        let addToCardImageView = UIImageView(image: addToCardImage!)
        addToCardImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        addToCardImageView.center = CGPoint(x: view.center.x, y: label.center.y + 100)
        self.view.addSubview(addToCardImageView)
        
        view.addBackground(imageName: phone!.background, contentMode: .scaleAspectFill)

        // Do any additional setup after loading the view.
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

extension UIView {
    func addBackground(imageName: String, contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)

        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
