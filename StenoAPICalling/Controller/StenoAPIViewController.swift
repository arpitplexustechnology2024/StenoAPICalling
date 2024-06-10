//
//  StenoAPIViewController.swift
//  StenoAPICalling
//
//  Created by Arpit iOS Dev. on 07/06/24.
//

import UIKit
import Alamofire

class StenoAPIViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var noInternetView: NoInternetView!
    var query: String?
    var items: [Datum] = []
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        setupNoInternetView()
        
        if let query = query {
            if isConnectedToInternet() {
                fetchData()
            } else {
                showNoInternetView()
            }
        }
    }
    
    func setupNoInternetView() {
        noInternetView = NoInternetView()
        noInternetView.translatesAutoresizingMaskIntoConstraints = false
        noInternetView.retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        view.addSubview(noInternetView)
        
        NSLayoutConstraint.activate([
            noInternetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noInternetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noInternetView.topAnchor.constraint(equalTo: view.topAnchor),
            noInternetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        noInternetView.isHidden = true
    }
    
    @objc func retryButtonTapped() {
        if isConnectedToInternet() {
            noInternetView.isHidden = true
            fetchData()
        } else {
            showAlert(title: "No Internet", message: "Please check your internet connection and try again.")
        }
    }
    
    func fetchData() {
        guard let nameValue = query else {
            print("Name value is missing")
            return
        }

        let url = "http://stenoapp.gautamsteno.com/api/get_words_practise_list"
        AF.request(url, method: .post, parameters: ["name": nameValue], encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let welcome = try JSONDecoder().decode(Welcome.self, from: jsonData)
                    self.items = welcome.data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                print("Alamofire request error: \(error)")
            }
        }
    }
    
    func showSkeletonLoader() {
        isLoading = true
        tableView.reloadData()
    }
    
    func hideSkeletonLoader() {
        isLoading = false
        tableView.reloadData()
    }
    
    func showNoInternetView() {
        DispatchQueue.main.async {
            self.noInternetView.isHidden = false
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func isConnectedToInternet() -> Bool {
        let networkManager = NetworkReachabilityManager()
        return networkManager?.isReachable ?? false
    }
    
    

}


// MARK: - TableView Dalegate & Datasource
extension StenoAPIViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let datum = items[indexPath.row]
           cell.configure(with: datum)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
}
