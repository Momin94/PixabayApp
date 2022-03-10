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
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
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
        // work out the total amount of space taken up by padding. You’ll have n + 1 evenly sized spaces, where n is the number of items in the row. You can take the space size from the left section inset.
        //  Subtracting that from the view’s width and dividing by the number of items in a row gives you the width for each item. You then return the size as a square.
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    // collectionView(_:layout:insetForSectionAt:) returns the spacing between the cells, headers and footers. A constant stores the value.
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    // This method controls the spacing between each line in the layout. You want this spacing to match the padding at the left and right.
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationController = storyboard.instantiateViewController(withIdentifier: "imagedetail") as? ImageDetailsViewController else {
            return
        }

        if indexPath.row <= imageViewModel.getCount() {
            let model = imageViewModel.imageAt(index: indexPath.row)
            destinationController.imageModel = model
            navigationController?.show(destinationController, sender: self)
        }
    }
}
