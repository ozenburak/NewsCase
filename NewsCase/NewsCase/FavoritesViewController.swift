//
//  FavoritesViewController.swift
//  NewsCase
//
//  Created by burak ozen on 19.02.2022.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    var newsResponse : NewsResponse?
    var detailFavorite : Article?
    
    var dataModel = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        dataModel = DAL.getAllData() ?? []
        favoritesTableView.reloadData()
        
        
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        
        cell.favoriteTitleLabel.text = dataModel[indexPath.row].title
        cell.favoriteExplainLabel.text = dataModel[indexPath.row].explain
        
        let media = dataModel[indexPath.row].newsimage
        cell.favoriteImageView.kf.setImage(with: URL(string: media!), placeholder: nil, options: nil, completionHandler: nil)

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailFavorite = newsResponse?.articles[indexPath.row]        
        performSegue(withIdentifier: "toDetailsFavoritesVC", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsFavoritesVC" {
            let vc = segue.destination as! DetailsNewsViewController
            vc.favoriteData = dataModel[sender as! Int]


            } else {


        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Interaction
        print("cell with path: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                 
                if editingStyle == .delete
                {
                    DAL.deleteFunc(data: dataModel[indexPath.row])
                    dataModel = DAL.getAllData() ?? []
                    favoritesTableView.reloadData()
                }
            }
    

}
