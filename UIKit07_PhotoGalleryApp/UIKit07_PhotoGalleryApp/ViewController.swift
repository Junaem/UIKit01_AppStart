//
//  ViewController.swift
//  UIKit07_PhotoGalleryApp
//
//  Created by 이준형 on 2022/10/19.
//

import UIKit
import PhotosUI // 포토, 갤러리 관련된 기능 라이브러리

class ViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery App"
        makeNavigationItems()
        
        let layout = UICollectionViewFlowLayout()   // 콜렉션 뷰 셀의 레이아웃
        layout.minimumInteritemSpacing = 10    // 셀끼리 가로 스페이싱
        layout.minimumLineSpacing = 10   // 세로 스페이싱
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - layout.minimumInteritemSpacing) / 2, height: 200)
        
        photoCollectionView.collectionViewLayout = layout
        photoCollectionView.dataSource = self
    }
    
    func makeNavigationItems() {
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .systemBlue.withAlphaComponent(0.7)
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(showGallery))
        photoItem.tintColor = .systemBlue.withAlphaComponent(0.7)
        
        
        self.navigationItem.leftBarButtonItem = refreshItem
        self.navigationItem.rightBarButtonItem = photoItem
    }
    
    
    @objc func showGallery() {
        let library = PHPhotoLibrary.shared() //shared는 싱글톤으로 가져온 우리 라이브러리
        
        var configuration = PHPickerConfiguration(photoLibrary: library)    // library에다 써먹을 설정
        configuration.selectionLimit = 10
        let picker = PHPickerViewController(configuration: configuration)   // 화면에 띄울 피커
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func refresh() {
        
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        return cell
    }
    
    
}


