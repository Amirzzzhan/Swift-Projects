//
//  ViewController.swift
//  GoodAsOldPhones
//
//  Created by Amirzhan Armandiyev on 18.10.2022.
//

import UIKit

class ProductsViewController: UIViewController {

    
    private var phoneNames = ["1907 Wall Set", "1921 Dial Phone", "1937 Desk Set", "1984 Moto Portable"]
    private var phoneImages = ["WallSet", "DialPhone", "DeskSet", "MotoPortable"]
    
    @IBOutlet weak var productsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = phoneNames[indexPath.row]
        
        let phoneImage = UIImage(named: phoneImages[indexPath.row])
        cell.imageView?.image = phoneImage
        let targetSize = CGSize(width: 110, height: 110)
        
        configuration.image = phoneImage?.scalePreservingAspectRatio(targetSize: targetSize)
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneVC = PhoneViewController()
        phoneVC.phone = Phone(phoneName: phoneNames[indexPath.row], background: phoneImages[indexPath.row] + "Background")
        navigationController?.pushViewController(phoneVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
            // Determine the scale factor that preserves aspect ratio
            let widthRatio = targetSize.width / size.width
            let heightRatio = targetSize.height / size.height
            
            let scaleFactor = min(widthRatio, heightRatio)
            
            // Compute the new image size that preserves aspect ratio
            let scaledImageSize = CGSize(
                width: size.width * scaleFactor,
                height: size.height * scaleFactor
            )

            // Draw and return the resized UIImage
            let renderer = UIGraphicsImageRenderer(
                size: scaledImageSize
            )

            let scaledImage = renderer.image { _ in
                self.draw(in: CGRect(
                    origin: .zero,
                    size: scaledImageSize
                ))
            }
            return scaledImage
        }
}

