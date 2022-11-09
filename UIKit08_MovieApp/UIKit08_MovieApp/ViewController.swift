//
//  ViewController.swift
//  UIKit08_MovieApp
//
//  Created by 이준형 on 2022/11/03.
//

import UIKit

class ViewController: UIViewController {
    
    var movieModel: MovieModel?
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
//    var data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        
        requestMovieApi()
    }

    func requestMovieApi() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        
        let term = URLQueryItem(name: "term", value: "marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        
        components?.queryItems = [term, media]
        guard let url = components?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            print( (response as! HTTPURLResponse).statusCode )
            
            if let hasData = data {
                do {
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    print(self.movieModel ?? "No data")
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()    // 클로져 안이기 때문에 매인 스레드에서 갱신
                    }
                } catch {
                    print(error)
                }
            }
        
        }
        task.resume()
        session.finishTasksAndInvalidate()
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
        
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        let price = self.movieModel?.results[indexPath.row].trackPrice.description ?? ""
        cell.priceLabel.text = currency + price
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
}
