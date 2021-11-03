//
//  NewsListViewController.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsItemCardList: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var news = [NewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsItemCardList.delegate = self
        newsItemCardList.dataSource = self
        
        
        //register collectionViewCell
        registerXIBCell()

    }

    
    func registerXIBCell(){
        newsItemCardList.register(UINib(nibName:"NewItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"NewItemCollectionViewCell")
    }

}

extension NewsListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewItemCollectionViewCell", for: indexPath) as! NewItemCollectionViewCell
            cell.configData(newItem: news[indexPath.row])
            return cell
    }
    
    
    
}
