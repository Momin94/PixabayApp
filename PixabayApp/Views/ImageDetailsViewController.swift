//
//  ImageDetailsViewController.swift
//  PixabayApp
//
//  Created by momin on 08/03/2022.
//

import SDWebImage
import UIKit

class ImageDetailsViewController: UIViewController {
    // MARK: - Properties
   
    @IBOutlet weak var labelHolderView: UIView!
    @IBOutlet weak var downloadsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var collectionsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageText: String?
    var imageModel: ImageCodable?

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadsLabel?.text = "\(String(describing: imageModel?.downloads))"
        likesLabel?.text = "\(String(describing: imageModel?.likes))"
        viewsLabel?.text = "\(String(describing: imageModel?.views))"
        collectionsLabel?.text = "\(String(describing: imageModel?.collections))"
        imageText = "\(imageModel?.largeImageURL ?? "")"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageURL = URL(string: imageText!)

        imageView.sd_setImage(with: imageURL) { image, error, _, _ in
            if error != nil {
                // Failed to load image
                self.imageView.image = UIImage(named: "TestImage.jpg")
            } else {
                // Successful in loading image
                self.imageView.image = image
            }
        }
    }
}
