import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    var news: [NewsModel] = []
    var articles: [Articles] = []
    var searching = false
    var searchedNews: [Articles] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func downloadJSON(completed: @escaping([Articles]) -> ()) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=ru&apiKey=37c24cd29815413593bb9c9c942cd59f")
        
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error == nil {
                do {
                    var response = try JSONDecoder().decode(NewsModel.self, from: data!)
                    dump(response)
                    DispatchQueue.main.async {
                        completed(response.list)
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
        
    }
    
    struct Cells {
        static let newsCell = "NewsCell"
    }
    
    private var newsTableView = UITableView()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedNews.count
        }
        else {
            return articles.count
        }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: Cells.newsCell) as! NewsCell
        let model = articles[indexPath.row]
        let searchedmodel = searchedNews[indexPath.row]
        
        if searching {
            cell.newsTitle.text = searchedmodel.title!
            cell.newsDescriptions.text = searchedmodel.description!
            cell.newsImage.image = UIImage(named: searchedmodel.urlToImage ?? "")
        }else {
        cell.newsTitle.text = model.title!
        cell.newsDescriptions.text = model.description!
        cell.newsImage.image = UIImage(named: model.urlToImage ?? "")
        }
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedNews.removeAll()
        newsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newsTableView.beginUpdates()
            articles.remove(at: indexPath.row)
            newsTableView.deleteRows(at: [indexPath], with: .fade)
            
            newsTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = DetailedNewsVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        rootVC.DetailedTitle.text = articles[indexPath.row].title!
        rootVC.DetailedDescription.text = articles[indexPath.row].description!
        present(navVC, animated: true)
    }
    
    private var firstView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новости"
        
        view.addSubview(firstView)
        firstView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        firstView.addSubview(newsTableView)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        configureSearchController()
        newsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: Cells.newsCell)
        
        downloadJSON { data in
            self.articles = data
            self.searchedNews = data
            self.newsTableView.reloadData()

        }
        }
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        if searchText == nil {
            searching = true
            searchedNews.removeAll()
            for item in articles {
                if item.title!.lowercased().contains(searchText?.lowercased() ?? "") {
                    searchedNews.removeAll()
                    searchedNews.append(item)
                }
            }
        }else {
            searching = false
            searchedNews.removeAll()
            searchedNews = articles
            
        }
        newsTableView.reloadData()
    }
    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var serchList: [Articles] = []
        
        articles.forEach { item in
            if ((item.title?.contains(searchText)) != nil) {
                serchList.removeAll()
                serchList.append(item)
            }
        }
        if searchText != nil{
        articles = serchList
        newsTableView.reloadData()
        }else{
            serchList.removeAll()
            serchList = articles
            newsTableView.reloadData()
        }
    }
    
}

