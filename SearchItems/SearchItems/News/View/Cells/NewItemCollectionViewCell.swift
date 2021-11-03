//
//  NewItemCollectionViewCell.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import UIKit
import Kingfisher

class NewItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 5
    }
    

    func configure(with viewModel : NewsListViewModel){
        newsImage.contentMode = .scaleAspectFill
        let url = URL(string: viewModel.image ?? "")
        newsImage.kf.setImage(with: url)
        
        newsTitle.text = viewModel.title
        newsSource.text = viewModel.source?.name
    }

}
