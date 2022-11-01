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
        
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .systemBlue.withAlphaComponent(0.7)
        
        
        self.navigationItem.leftBarButtonItem = refreshItem
        self.navigationItem.rightBarButtonItem = photoItem
    }
    
    @objc func checkPermission() {
        print("실행됨")
        if PHPhotoLibrary.authorizationStatus() == .authorized ||
            PHPhotoLibrary.authorizationStatus() == .limited {
            DispatchQueue.main.async {  // 아래 notDetermined에서 재귀로 실행될 때 메인이 아닌곳에서 실행되기 때문에 화면을 건드리는 showGallery를 무조건 메인에서 실행되게 해줘야함
                self.showGallery()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .denied { // 설정으로 보내는 알람
            DispatchQueue.main.async {
                self.showAuthorizationDeniedAlert()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                self.checkPermission() // 여기서 한 번 결정하게 request하기 때문에 다시 재귀했을때는 이 선택지로 안 빠짐
                // closure 안에서 진행되는거라서 메인 스레드가 아님.
            }
        }
    }
    
    func showAuthorizationDeniedAlert() {
        let alert = UIAlertController(title: "포토 라이브러리 접근 권한을 활성화 해주세요.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
            guard let url = URL(string:UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true)
    }
    
    @objc func showGallery() {
        let library = PHPhotoLibrary.shared() //shared는 싱글톤으로 가져온 우리 라이브러리
        
        var configuration = PHPickerConfiguration(photoLibrary: library)    // library에다 써먹을 설정
        configuration.selectionLimit = 10
        let picker = PHPickerViewController(configuration: configuration)   // 화면에 띄울 피커
        picker.delegate = self
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

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true)
    }
    
    
}


