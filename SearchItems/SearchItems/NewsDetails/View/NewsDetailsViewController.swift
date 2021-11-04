//
//  NewsDetailsViewController.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import UIKit
import Alamofire

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var newsImageShape: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newscontent: UILabel!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsPageURL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    
    func configure(with viewModel : NewsListViewModel){
//        newsImageShape.contentMode = .scaleAspectFill
//        let url = URL(string: viewModel.image ?? "")
//        newsImageShape.kf.setImage(with: url)

        
        newsTitle.text = viewModel.title
        newsDesc.text = viewModel.description
//        newsAuthor.text = viewModel.author
//        newscontent.text = viewModel.content
//        newsSourceName.text = viewModel.source?.name
//        newsDate.text = viewModel.date
//        newsPageURL.text = viewModel.pageOfImage

        //        self.imageTapped(imageURL: photos[indexPath.row].download_url)

    }
    
    
    
func imageTapped(imageURL:String){
    let url = URL(string: imageURL)
    let newImageView = UIImageView(image: UIImage())
    newImageView.kf.setImage(with: url)
    
    newImageView.frame = UIScreen.main.bounds
    newImageView.backgroundColor = .black
    newImageView.contentMode = .scaleAspectFit
    newImageView.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
    newImageView.addGestureRecognizer(tap)
    self.view.addSubview(newImageView)
    self.navigationController?.isNavigationBarHidden = true
    self.tabBarController?.tabBar.isHidden = true
}

@objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
    self.navigationController?.isNavigationBarHidden = false
    self.tabBarController?.tabBar.isHidden = false
    sender.view?.removeFromSuperview()
}

}
        
