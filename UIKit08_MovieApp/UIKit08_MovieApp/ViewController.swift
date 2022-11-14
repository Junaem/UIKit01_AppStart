//
//  ViewController.swift
//  UIKit08_MovieApp
//
//  Created by 이준형 on 2022/11/03.
//

import UIKit

class ViewController: UIViewController {
    
    var movieModel: MovieModel?
    var networkLayer = NetworkLayer()
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
//    var data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func requestMovieApi(searchString: String) {
        let term = URLQueryItem(name: "term", value: searchString)
        let media = URLQueryItem(name: "media", value: "movie")
        let queries = [term, media]
        
        networkLayer.request(type: .searchMovie(queries: queries)) { data, response, error in
            if let hasData = data {
                do {
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()    // 클로져 안이기 때문에 매인 스레드에서 갱신
                    }
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {   // 클로져 안에서 사용한 파라미터, 데이터들이 클로져 밖에서도 사용할 수 있게 escaping. 이래야 함수가 종료된 뒤에 클로져가 실행 가능
        networkLayer.request(type: .onlyURL(urlString: urlString)) { data, response, error in
            if let hasData = data {
                completion(UIImage(data: hasData))
                return
            }
        }
    }
    
//    NetworkLayout 사용 안 했을 때
//    func requestMovieApi(searchString: String) {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        var components = URLComponents(string: "https://itunes.apple.com/search")
//
//        let term = URLQueryItem(name: "term", value: searchString)
//        let media = URLQueryItem(name: "media", value: "movie")
//
//        components?.queryItems = [term, media]
//        guard let url = components?.url else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let task = session.dataTask(with: request) { data, response, error in
//            print( (response as! HTTPURLResponse).statusCode )
//
//            if let hasData = data {
//                do {
//                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
//                    DispatchQueue.main.async {
//                        self.movieTableView.reloadData()    // 클로져 안이기 때문에 매인 스레드에서 갱신
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//
//        }
//        task.resume()
//        session.finishTasksAndInvalidate()
//
//    }
//
//    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {   // 클로져 안에서 사용한 파라미터, 데이터들이 클로져 밖에서도 사용할 수 있게 escaping. 이래야 함수가 종료된 뒤에 클로져가 실행 가능
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        if let hasURL = URL(string: urlString) {
//            var request = URLRequest(url: hasURL)
//            request.httpMethod = "GET"
//
//            session.dataTask(with: request) { data, response, error in
//
//                if let hasData = data {
//                    completion(UIImage(data: hasData))
//                    return
//                }
//            }.resume()  // datatask는 반드시 실행해야함
//            session.finishTasksAndInvalidate()
//        }
//        completion(nil) //  iflet을 통과 못해서 밑으로 내려오면 completion이 실행 안되서 메모리를 계속 잡고 있어서 실행시켜줘야됨. 안 해도 에러가 나지 않지만 호출 안 된 클로져가 메모리 계속 있는다고 함.
//    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.resultCount ?? 0
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    } // 이거나 위에거 안 써도 컨텐츠 크기만큼 높이가 잡히지만 ios 예전 버전에서는 안 되서 직접 해주면 좋음
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
        
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        let price = self.movieModel?.results[indexPath.row].trackPrice?.description ?? ""
        cell.priceLabel.text = currency + price
        
        if let hasImage = self.movieModel?.results[indexPath.row].image {
            self.loadImage(urlString: hasImage) { image in
                DispatchQueue.main.async {
                    cell.movieImageView.image = image
                }
            }
        }
        
        if let dateString = self.movieModel?.results[indexPath.row].releaseDate {
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.string(from: isoDate)
                
                cell.dateLabel.text = date
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 앞에 있는 네임은 storyboard의 파일명, 뒤의 identifier는 storyboard 내 실제 VC의 identifier
        let detailVC = UIStoryboard(name: "MovieDetailViewController", bundle: nil).instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        detailVC.movieResult = self.movieModel?.results[indexPath.row]
//        self.present(detailVC, animated: true) {
//            detailVC.movieResult = self.movieModel?.results[indexPath.row]
//        }
        detailVC.modalPresentationStyle = .automatic
        self.present(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let hasText = searchBar.text else {   // 검색어가 없으면 필요없으니 guard let
            return
        }
        requestMovieApi(searchString: hasText)
        self.view.endEditing(true)
    }
    
}
