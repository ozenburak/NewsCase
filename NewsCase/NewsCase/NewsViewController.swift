//
//  NewsViewController.swift
//  NewsCase
//
//  Created by burak ozen on 19.02.2022.
//
//https://newsapi.org/v2/everything?q=besiktas&amp;page=1&amp;apiKey=e8727d49d8c64dfdbb8dedff168cb185


import UIKit
import Alamofire
import Kingfisher

class NewsViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var newsSearchBar: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView!
    
    private var searchHelper : SearchHelper?
    
    var newsResponse : NewsResponse?
    var articles: [Article] = [Article]()
    var detailNews : Article?
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTableView.delegate = self
        newsTableView.dataSource = self

        newsSearchBar.delegate = self
        
        
        prepareSearchHelper()

    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let text = searchBar.text {
                
                searchHelper?.handleTyping(text: text)
            
        }
        
    }
    
    
    func prepareSearchHelper () {
        searchHelper = SearchHelper(interval: 0.4, handler: { text in
            
            Network.getNewsData(query: text, complationHandler: { response in
                self.articles.removeAll()
                self.articles.append(contentsOf: response.articles)
                self.newsTableView.reloadData()
            }, errorHandler: {error in
            
                print("error")
            })
        })
    }
    

}

 


extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.newsTitleLabel.text = self.articles[indexPath.row].title
        cell.newsExplainLabel.text = self.articles[indexPath.row].articleDescription
        
//        kingfisher
        let media = self.articles[indexPath.row]
        let str = "\(media.urlToImage ?? "")"
        cell.newsImageView.kf.setImage(with: URL(string: str), placeholder: nil, options: nil, completionHandler: nil)
        
        return cell
    }
    
    
    //    details VC data
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailsNewsVC" {
                let vc = segue.destination as! DetailsNewsViewController
                vc.news = detailNews


                } else {


            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailNews = self.articles[indexPath.row]
        performSegue(withIdentifier: "toDetailsNewsVC", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Interaction
        print("cell with path: \(indexPath.row)")
    }
    
    
    
    
}

