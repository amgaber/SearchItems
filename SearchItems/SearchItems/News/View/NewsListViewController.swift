//
//  NewsListViewController.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import UIKit
import Alamofire

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsItemCardList: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var SearchBarValue:String!
    var searchActive : Bool = false
    private var filtered = [NewData]()
    
    
    private var news = [NewData]()
    let APIKEY = kKeyAPIKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsItemCardList.delegate = self
        newsItemCardList.dataSource = self
        
        filtered = []
        
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = false

       
        //register collectionViewCell
        registerXIBCell()
        

        //call Api
//        getNewsList()
        
        //for test
        news.append(NewData(title: "test", description: "sdgsdghsaghhgdaldagdjagdjas", author: "Alaa", source: Source(id: "", name: "source"), content: "kdjjdalja", date: "20/3/2021", image: "https://www.reuters.com/pf/resources/images/reuters/reuters-default.png?d=55", pageOfImage: "https://www.wired.com/story/big-tech-ethics-bug-bounty/"))
        news.append(NewData(title: "mobile iphone", description: "sdgsdghsaghhgdaldagdjagdjas", author: "Alaa", source: Source(id: "", name: "source"), content: "kdjjdalja", date: "20/3/2021", image: "https://images.hindustantimes.com/tech/img/2021/11/03/1600x900/75e22248-2c0a-11ec-8f97-860cbef0b633_1635923815766_1635923838060.jpg", pageOfImage: "https://www.wired.com/story/big-tech-ethics-bug-bounty/"))
        news.append(NewData(title: "mobile iphone", description: "sdgsdghsaghhgdaldagdjagdjas", author: "Alaa", source: Source(id: "", name: "source"), content: "kdjjdalja", date: "20/3/2021", image: "https://images.hindustantimes.com/tech/img/2021/11/03/1600x900/75e22248-2c0a-11ec-8f97-860cbef0b633_1635923815766_1635923838060.jpg", pageOfImage: "https://www.wired.com/story/big-tech-ethics-bug-bounty/"))
        news.append(NewData(title: "mobile iphone", description: "sdgsdghsaghhgdaldagdjagdjas", author: "Alaa", source: Source(id: "", name: "source"), content: "kdjjdalja", date: "20/3/2021", image: "https://images.hindustantimes.com/tech/img/2021/11/03/1600x900/75e22248-2c0a-11ec-8f97-860cbef0b633_1635923815766_1635923838060.jpg", pageOfImage: "https://www.wired.com/story/big-tech-ethics-bug-bounty/"))
        self.newsItemCardList.reloadData()
        filtered = news

    }

    
    func registerXIBCell(){
        newsItemCardList.register(UINib(nibName:"NewItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"NewItemCollectionViewCell")
    }
    
    
    func getNewsList(){
        let requestNews = AF.request("https://newsapi.org/v2/everything?q=Apple&from=2021-11-03&sortBy=popularity&apiKey=\(APIKEY)")
        requestNews.responseDecodable(of: DataResult.self) { (response) in
//             guard let data = response.result else { return }
//            self.news = data
            debugPrint("response: ", response.result)
            
            self.newsItemCardList.reloadData()
        }
    }

}

extension NewsListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive){
               return filtered.count
        }
         else{
             return news.count
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let newsModel = searchActive == true ?  filtered[indexPath.row] : news[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewItemCollectionViewCell", for: indexPath) as! NewItemCollectionViewCell
        cell.configure(with: NewsListViewModel(with: newsModel))
            return cell
    }
    
    
    
}


//Serach delegate applied to search items by title
extension NewsListViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = true
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchActive = false
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false;

            searchBar.text = nil
            searchBar.resignFirstResponder()
            self.newsItemCardList.resignFirstResponder()
            self.searchBar.showsCancelButton = false
            self.newsItemCardList.reloadData()
        }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
        }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

                self.searchActive = true;
                self.searchBar.showsCancelButton = true


                filtered = []

                
                filtered = news.filter { data  -> Bool in
                    return data.title?.lowercased().contains(searchText.lowercased()) ?? false
                }

                self.newsItemCardList.reloadData()

            }
        
}
