import UIKit

struct APIResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}

class SearchViewController: UIViewController {
    
    let urlString = "https://rickandmortyapi.com/api/character/"
    
    var collectionView: UICollectionView?
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width / 2, height: view.frame.height / 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // collectionView.dataSource = self
        view.addSubview(collectionView)
        
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
           
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
