//
//  ViewController.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import UIKit
import Reachability
import RxReachability
import RxSwift

class CarsListViewController: UIViewController {

    //MARK: - Outlets
    /// Listing TableView Outlet
    @IBOutlet weak var carsListTableView: UITableView!
    /// Error Label Outlet
    @IBOutlet weak var errorLabel: UILabel!
    /// Error View Outlet
    @IBOutlet weak var errorRetryView: UIView!
    /// Top Bar Outlet
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    /// Pull to Refresh Property
    let pullToRefresh = UIRefreshControl()
    /// Cars ViewModel Property
    var carsViewModel = CarsViewModel()
    /// Dispose Bag Property
    let disposeBag = DisposeBag()
    /// Reachable Property
    var isReachable: Bool = false {
        didSet {
            checkForInternetConnectivity()
        }
    }

    //MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        carsListTableView.refreshControl = pullToRefresh
        self.carsListTableView.isHidden = true
        
        topBarHeightConstraint.constant = UIDevice.current.hasNotch ? 84 : 64
        
        let nib = UINib(nibName: String(describing: CarsListTableViewCell.self), bundle: nil)
        carsListTableView.register(nib, forCellReuseIdentifier: CarsListTableViewCell.cellIdentifier)
        
        subscribeReachability()
    }

    //MARK: - Fetch Data Methods
    private func fetchData() {
        self.errorRetryView.isHidden = true
        self.view.showLoadingIndicator()
        carsViewModel.getCarsListData { [weak self] success, error in
            DispatchQueue.main.async {
                if let self = self {
                    self.view.hideLoadingIndicator()
                    self.pullToRefresh.endRefreshing()
                    self.carsListTableView.reloadData()
                    self.carsListTableView.isHidden = !success
                    if let error = error {
                        self.errorLabel.text = error
                        self.errorRetryView.isHidden = false
                        self.carsListTableView.isHidden = true
                        if self.checkForOfflineData() {
                            self.carsListTableView.reloadData()
                            self.errorRetryView.isHidden = true
                            self.carsListTableView.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    private func subscribeReachability() {
        Reachability.rx.isReachable
            .subscribe(onNext: { [weak self] reachable in
                debugPrint("Is reachable: \(reachable)")
                self?.isReachable = reachable
            })
            .disposed(by: disposeBag)
    }
    
    private func checkForInternetConnectivity() {
        
        if self.isReachable {
            debugPrint("Internet connection OK")
            self.fetchData()
        } else {
            debugPrint("Internet connection FAILED")
            if self.checkForOfflineData() {
                self.carsListTableView.reloadData()
                self.errorRetryView.isHidden = true
                self.carsListTableView.isHidden = false
            } else {
                self.errorLabel.text = "Internet Connection not Available! \nPlease click 'Retry' after you are connected to internet"
                self.errorRetryView.isHidden = false
                self.carsListTableView.isHidden = true
            }
        }
    }
    
    private func checkForOfflineData() -> Bool {
        if let data = UserDefaults.standard.object(forKey: OFFLINE_DATA_KEY) as? Data,
            let dataModel = NSKeyedUnarchiver.unarchiveObject(with: data) as? CarListDataModel {
            self.carsViewModel.setDatasource(model: dataModel)
            return true
        }
        return false
    }

    //MARK: - Action Methods
    @IBAction func didTapRetryButton(_ sender: UIButton) {
        checkForInternetConnectivity()
    }
}

//MARK: - TableView Datasource Methods
extension CarsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CarsListTableViewCell.cellIdentifier, for: indexPath) as? CarsListTableViewCell {
            cell.carTitleLabel.text = carsViewModel.carTitle(index: indexPath.row)
            cell.carDateLabel.text = carsViewModel.carDateTime(index: indexPath.row)
            cell.carDescriptionLabel.text = carsViewModel.carDescription(index: indexPath.row)
            if let url = carsViewModel.carImageURL(index: indexPath.row) {
                cell.carImageView.downloadImage(withUrl: url)
            }
            cell.layoutSubviews()
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if pullToRefresh.isRefreshing {
            self.checkForInternetConnectivity()
        }
    }
}
