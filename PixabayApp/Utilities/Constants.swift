//
//  Constants.swift
//  PixabayApp
//
//  Created by momin on 08/03/2022.
//

import Foundation

class Constants {
    static let shareInstance = Constants()

    var cellName: String = "ImageCell"
    var baseAPI: String = "https://pixabay.com/api/?key="
    var APIkey: String = "26050541-b6775e5808f96436defeae874"
    var APIParams: String = "&q=arsenal+football&image_type=photo&pretty=true"

    func getCellName() -> String { return cellName }
    func getBaseAPI() -> String { return baseAPI }
    func getAPIKey() -> String { return APIkey }
    func getAPIParams() -> String { return APIParams }
}
