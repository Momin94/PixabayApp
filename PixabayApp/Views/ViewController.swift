//
//  ViewController.swift
//  PixabayApp
//
//  Created by momin on 08/03/2022.
//

import SDWebImage
import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var vieww: UICollectionView!
   
    
    var imageViewModel = ViewModel()
    
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 10.0,
        bottom: 20.0,
        right: 10.0)
    
    private let itemsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        vieww.register(UINib(nibName: Constants.shareInstance.getCellName(),
                                 bundle: nil),
                           forCellWithReuseIdentifier: Constants.shareInstance.getCellName())

        imageViewModel.getImage { _ in
            DispatchQueue.main.async {
                self.vieww.reloadData()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // 2
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return imageViewModel.getCount()
    }

    // 3
    override func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.shareInstance.getCellName(),
            for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .black
        if indexPath.row <= imageViewModel.getCount() {
            let modelImage = imageViewModel.imageAt(index: indexPath.row)
            cell.title.text = "\(modelImage.id)"
            let imageURL = URL(string: modelImage.previewURL )
            cell.image.sd_setImage(with: imageURL)
        }
        // Configure the cell
        return cell
    }

    // tells the layout the size of a given cell.
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let destinationController = ImageDetailsViewController(nibName: "ImageDetailsViewController", bundle: nil) 

        if indexPath.row <= imageViewModel.getCount() {
            let model = imageViewModel.imageAt(index: indexPath.row)
            destinationController.imageModel = model
            navigationController?.show(destinationController, sender: self)
        }
    }
}
