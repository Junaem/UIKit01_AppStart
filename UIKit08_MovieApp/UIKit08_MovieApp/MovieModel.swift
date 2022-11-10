//
//  MovieModel.swift
//  UIKit08_MovieApp
//
//  Created by 이준형 on 2022/11/09.
//

import Foundation

struct MovieModel: Codable {    // Json 바로 인코딩, 디코딩 가능하게 해주는 프로토콜
    let resultCount: Int
    let results: [MovieResult]
    
}

struct MovieResult: Codable {
    let trackName: String  // api에서 없을 수도 있으니 Optional
    let previewUrl: String
    let image: String
    let shortDescription: String?
    let longDescription: String
    let currency: String
    let trackPrice: Double
    let releaseDate: String
//    let releaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case image = "artworkUrl100"    // 인코딩했을때는 aU100, 디코딩했을때는 image
        case trackName  // 같은 이름 그대로 쓸거면 뒤에 값은 안 넣어도 됨
        case previewUrl
        case shortDescription
        case longDescription
        case currency
        case trackPrice
        case releaseDate
    }
}
