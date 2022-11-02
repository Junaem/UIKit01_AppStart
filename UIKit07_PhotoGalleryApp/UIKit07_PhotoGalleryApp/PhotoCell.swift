//
//  PhotoCell.swift
//  UIKit07_PhotoGalleryApp
//
//  Created by 이준형 on 2022/10/19.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill   //  셀이 본인이 보일 곳을 꽉 채우게
        }
        
    }
    
    func loadImage(asset: PHAsset) {
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat  // 저화질만 필요하거나 하면 이렇게 옵션만들어서 requestImage에서 변경 가능. 지금은 적용 x
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil) { image, info in
            if (info?[PHImageResultIsDegradedKey] as? Bool) == true {
                // 저화질임, false면 원본화질
            }
            self.photoImageView.image = image
        }   // 여기에 aspectFill은 셀 안을 꽉 채우게
        
    }
}
