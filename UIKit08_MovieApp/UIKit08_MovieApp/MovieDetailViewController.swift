//
//  MovieDetailViewController.swift
//  UIKit08_MovieApp
//
//  Created by 이준형 on 2022/11/10.
//

import UIKit
import AVKit // AudioVideo Kit

class MovieDetailViewController: UIViewController {
    
    var movieResult: MovieResult?
//        didSet {
//            titleLabel.text = movieResult?.trackName    // IBOutlet으로 화면과 연결된 title은 viewDidLoad때 생성되야 접근이 됨. 따라서 바로 이렇게 넣으려면 completion을 통해 detailVC가 다 생성된 뒤에 movieResult를 set해줘야 됨. - 다만 이렇게 했을 경우 값이 들어가기 전 잠시동안 기본 텍스트가 보임 따라서 여기서 말고 viewdidload에서 값을 뿌려주는게 좋음
//            descriptionLabel.text = movieResult?.longDescription
//        }
    
    var player: AVPlayer?
    
    @IBOutlet weak var movieContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    
    
    override func viewDidLoad() {   // 여기서는 실제 디바이스의 크기값을 아직 안 가져옴. 여기서 크기값을 정해버리면 실제 크기와 차이가 생길 수 있음
        super.viewDidLoad()
        
        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
    }
    
    override func viewDidAppear(_ animated: Bool) { // 여기서 해야 실제 디바이스 크기에 맞출 수 있음
        if let hasUrl = movieResult?.previewUrl {
            makePlayerAndPlay(urlString: hasUrl)
        }
    }
    
    func makePlayerAndPlay(urlString: String) {
        if let hasUrl = URL(string: urlString) {
            self.player = AVPlayer(url: hasUrl)
            let playerLayer = AVPlayerLayer(player: player) // 크기를 가진 레이어에 플레이어를 넣음.

            movieContainer.layer.addSublayer(playerLayer) // 뷰가 아니라 레이어임으로 addSubView가 아닌 SubLayer.
            playerLayer.frame = movieContainer.bounds   // 레이어는 뷰가 아니라 오토 레이아웃이 안됨. 강제로 프레임을 컨테이너 크기에 맞춤.
            // movieContainer.frame은 본인 superView에서 쓴 좌표시스템, bounds는 본인의 좌표시스템을 보여주는데 여기서는 컨테이너와 그 자식인 layer의 관계이기 때문에 bounds를 써야함.
            
            self.player?.play()
        }
    }
    
    @IBAction func play(_ sender: Any) {
        self.player?.play()
    }
    @IBAction func stop(_ sender: Any) {
        self.player?.pause()
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
