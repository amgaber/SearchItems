//
//  NewsListViewController.swift
//  SearchItems
//
//  Created by Alaa Gaber on 11/3/21.
//

import UIKit
import Alamofire
import RxSwift
class NewsListViewController: UIViewController {

    @IBOutlet weak var newsItemCardList: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var SearchBarValue:String!
    var searchActive : Bool = false
    private var filtered = [NewData]()
    
    private var news = [NewData]()
    let APIKEY = kKeyAPIKey
    
    typealias ViewModel = NewsListViewModel
    var viewModel: NewsListViewModel!
    
    private let disposeBag = DisposeBag()

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
        getNewsList()

    }

    
    func registerXIBCell(){
        newsItemCardList.register(UINib(nibName:"NewItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"NewItemCollectionViewCell")
    }
    
    
    func getNewsList(){
        AF.request("https://newsapi.org/v2/everything?q=Apple&from=2021-11-03&sortBy=popularity&apiKey=\(APIKEY)").validate().responseJSON { response in

                       guard response.response?.statusCode != 403 else
                       {
                          print("Session expired, Must relogin")
                           return
                       }
                       guard response.response?.statusCode != 500 else
                       {
                           print("Something Went wrong, please refresh")
                           return
                       }
                       guard response.response?.statusCode != 504 else
                       {
                           debugPrint("Gateway timeout, Please refresh")
                           return
                       }
                       switch response.result {
                       case .success:
                           do{
                               debugPrint("res:" , response.result)
                               let res = try JSONDecoder().decode(DataResult.self, from:response.data!)
                               debugPrint("DataResult:" , res.articles?.count)
                            
                               self.news = res.articles ?? []
                               debugPrint("title:",res.articles?[1].title)

                               self.filtered = self.news

                               self.newsItemCardList.reloadData()
                           }
                          catch {
                              debugPrint(error.localizedDescription)

//                              completionHandler(nil, error)
                          }
                       case .failure(let error):


                           debugPrint(error.localizedDescription)
//                           completionHandler(nil, error)
                       }
        }}

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
    
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width , height: 400)
    }

    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        let newsModel = searchActive == true ?  filtered[indexPath.row] : news[indexPath.row]
//        vc.configure(with: NewsListViewModel(with: newsModel))
//        self.navigationController?.pushViewController(vc, animated: true)
        
        self.imageTapped(imageURL: newsModel.image ?? "")

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
