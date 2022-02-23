//
//  DetailsNewsViewController.swift
//  NewsCase
//
//  Created by burak ozen on 20.02.2022.
//

import UIKit
import Alamofire
import Kingfisher
import SafariServices

class DetailsNewsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailTimeLabel: UILabel!
    @IBOutlet weak var detailSummaryTextView: UITextView!
    
    
    @IBOutlet weak var favoriteBTN: UIBarButtonItem!
    
    var news : Article?
    var favoriteData : News?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailSummaryTextView.delegate = self
        
        
        if news != nil {
            
            detailTitleLabel.text = news?.title
            detailAuthorLabel.text = news?.author
            detailSummaryTextView.text = news?.articleDescription
            detailTimeLabel.text = news?.publishedAt
            
            let str = "\(news?.urlToImage ?? "")"
            self.detailImageView.kf.setImage(with: URL(string: str), placeholder: nil, options: nil, completionHandler: nil)
            
        } else if favoriteData != nil {
            
            detailTitleLabel.text = favoriteData?.title
            detailAuthorLabel.text = favoriteData?.author
            detailSummaryTextView.text = favoriteData?.explain
            detailTimeLabel.text = favoriteData?.newsdate
            
            let media = "\(favoriteData?.newsimage ?? "")"
            self.detailImageView.kf.setImage(with: URL(string: media), placeholder: nil, options: nil, completionHandler: nil)
        }
        
        
        

        
    }
    
    @IBAction func shareBTN_TUI(_ sender: Any) {
        
               let text = "News share here."
               
               let textToShare = [ text ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view
               
               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
               
               self.present(activityViewController, animated: true, completion: nil)
               
    }
    
    
    @IBAction func addFavoriteBTN_TUI(_ sender: Any) {
        
        
        DAL.saveData(title: news!.title, author: news?.author ?? "" , newsdate: news!.publishedAt, explain: news!.articleDescription, newsimage: news!.urlToImage, setfavorite: true, weburl: news!.url)
        
        
    }
    
    @IBAction func newsSourceBTN_TUI(_ sender: Any) {
        
        if news != nil {
            
            let url = news?.url
            let vc = SFSafariViewController(url: URL(string: url ?? "")!)
            present(vc, animated: true)
            
        } else if favoriteData != nil {
            
            let data = favoriteData?.weburl
            let vc = SFSafariViewController(url: URL(string: data ?? "")!)
            present(vc, animated: true)
            
        }
        
        
    }
}

