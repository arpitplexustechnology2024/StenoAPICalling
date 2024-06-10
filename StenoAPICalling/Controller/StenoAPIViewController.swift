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
    var noDataView: NoDataView!
    var query: String?
    var items: [Datum] = []
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "stenoTableViewCell", bundle: nil), forCellReuseIdentifier: "stenoTableViewCell")
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.register(SkeletonTableViewCell.self, forCellReuseIdentifier: "SkeletonCell")
        
        setupNoInternetView()
        setupNoDataView()
        
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
    
    func setupNoDataView() {
        noDataView = NoDataView()
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noDataView)
        
        NSLayoutConstraint.activate([
            noDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noDataView.topAnchor.constraint(equalTo: view.topAnchor),
            noDataView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        noDataView.isHidden = true
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
        showSkeletonLoader()
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.hideSkeletonLoader()
                        if welcome.status == 0 {
                            self.items = welcome.data
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } else {
                            self.showNoDataView()
                        }
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
    
    func showNoDataView() {
        noDataView.isHidden = false
        tableView.isHidden = true
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 10 : items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "stenoTableViewCell") as! stenoTableViewCell
            
            return Cell
        } else {
            if isLoading {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SkeletonCell", for: indexPath) as! SkeletonTableViewCell
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
                    return UITableViewCell()
                }
                let datum = items[indexPath.row]
                cell.idLbl.text = datum.id
                cell.nameLbl.text = datum.name
                switch datum.extPath {
                case .pdf:
                    cell.extPathIcon.image = UIImage(named: "pdf")
                case .mp4:
                    cell.extPathIcon.image = UIImage(named: "audio")
                default:
                    cell.extPathIcon.image = nil
                }
                cell.extPath1Lbl.text = datum.extPath1
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 57
        } else {
            return 65
        }
    }
}
