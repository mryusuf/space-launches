//
//  LaunchWatchlistView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 20/11/20.
//

import UIKit

protocol LaunchWatchlistViewProtocol: class {
  
  var presenter: LaunchWatchlistPresenterProtocol? { get set }
  func startLoading()
  func stopLoading()
  func displayLaunches(_ launches: [LaunchModel])
  func showEmptyState()
  
}

class LaunchWatchlistView: UIViewController {
  
  var presenter: LaunchWatchlistPresenterProtocol?
  private weak var containerView: UIView?
  private weak var launchTableView: LaunchTableView?
  private weak var activityIndicator: UIActivityIndicatorView?
  internal var isLoading = false
  
  init() {
      super.init(nibName: nil, bundle: nil)
      
      self.title = "Launch Watchlist"
    
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
    setupIndicatorView()
    setupLaunchesTableView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    print("LaunchWatchlistView viewWillAppear")
    self.presenter?.loadLaunches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    self.navigationController?.navigationBar.prefersLargeTitles = true
//    self.navigationController?.navigationBar. = true
//    self.navigationItem.largeTitleDisplayMode = .never
    
//    self.navigationController?.hidesBarsOnSwipe = true
    self.navigationItem.largeTitleDisplayMode = .always
    
  }
  
}

extension LaunchWatchlistView {
  
  func setupIndicatorView() {
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(activityIndicator)
    self.activityIndicator = activityIndicator
    
    self.activityIndicator?.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
  }
  
  func setupLaunchesTableView() {
    
    let launchTableView = LaunchTableView()
    launchTableView.setup()
    launchTableView.delegate = self
    self.view.addSubview(launchTableView)
    
    launchTableView.snp.makeConstraints { make in
      make.left.right.equalTo(self.view)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(0)
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).offset(0)
    }
    
    self.launchTableView = launchTableView
    
  }
}

extension LaunchWatchlistView: LaunchWatchlistViewProtocol {
  func startLoading() {
    
    isLoading = true
    self.activityIndicator?.isHidden = false
    self.launchTableView?.isHidden = true
    self.activityIndicator?.startAnimating()
    
  }
  
  func stopLoading() {
    
    self.activityIndicator?.stopAnimating()
    self.activityIndicator?.isHidden = true
    self.launchTableView?.isHidden = false
    
  }
  
  func displayLaunches(_ launches: [LaunchModel]) {
    
    self.launchTableView?.displayPreviousLaunches(launches)
  }
  
  func showEmptyState() {
    
    self.launchTableView?.isHidden = true
    let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    emptyLabel.text = "No Launches in your Watchlist yet :("
    emptyLabel.font = .systemFont(ofSize: 14, weight: .medium)
    
    self.view.addSubview(emptyLabel)
    
    emptyLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
  }
  
}

extension LaunchWatchlistView: LaunchTableViewProtocol {
  
  func didSelectLaunch(_ launch: LaunchModel) {
    
    self.presenter?.showDetailLaunch(with: launch)
    
  }
}
