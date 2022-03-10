//
//  ViewModel.swift
//  PixabayApp
//
//  Created by momin on 08/03/2022.
//

import Alamofire
import UIKit.UIImage

class ViewModel {
    // MARK: - Properties
    private var picturesArray = [ImageCodable]()
    weak var imageViewController: ViewController?

    // MARK: - Methods
    func getImage(callback: @escaping ([ImageCodable]) -> Void) {
        guard let url = URL(string: "\(Constants.shareInstance.getBaseAPI())\(Constants.shareInstance.getAPIKey())\(Constants.shareInstance.getAPIParams())") else {
            return
        }
        
        ApiService.shareInstance.getAllImages(url: url) { response in
            let images = response.images
            
                self.picturesArray.append(contentsOf: images)
            
            callback(self.picturesArray)
        } faliure: { errorMessage in
            print(errorMessage)
        }
    }

    func getCount() -> Int {
        return picturesArray.count
    }
    
    func imageAt(index: Int) -> ImageCodable {
        return picturesArray[index]
    }
}
