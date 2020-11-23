//
//  LaunchesView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

protocol LaunchesViewProtocol: class {
  
  var presenter: LaunchesPresenterProtocol? { get set }
  func startLoading()
  func stopLoading()
  func displayUpcomingGoLaunches(_ launches: [LaunchModel])
  func displayPreviousLaunches(_ launches: [LaunchModel])
  
}

class LaunchesView: UIViewController {
  
  var presenter: LaunchesPresenterProtocol?
  private weak var scrollView: UIScrollView?
  private weak var containerView: UIView?
  private weak var upcomingGoCollectionView: UpcomingGoLaunchView?
  private weak var previousLaunchesTableView: LaunchTableView?
  private weak var upcomingLabel: UILabel?
  private weak var previousLabel: UILabel?
  private weak var activityIndicator: UIActivityIndicatorView?
  internal var isLoading = false
  
  init() {
      super.init(nibName: nil, bundle: nil)
      
      self.title = "Space Launches"
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
    setupIndicatorView()
    setupScrollView()
    setupUpcomingGoCollectionView()
    setupPreviousLaunchesTableView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.presenter?.loadLaunches()
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    self.view.backgroundColor = .systemBackground
  }
  
}

extension LaunchesView {
  
  func setupIndicatorView() {
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(activityIndicator)
    self.activityIndicator = activityIndicator
    
    self.activityIndicator?.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
  }
  
  func setupScrollView() {
    
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    self.view.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(self.view)
    }
    
    let cv = UIView()
    cv.backgroundColor = .systemBackground
    scrollView.addSubview(cv)
    cv.snp.makeConstraints { make in
      make.top.bottom.equalTo(scrollView)
      make.left.right.equalTo(self.view)
      make.bottom.equalTo(scrollView.snp.bottom)
    }
    
    self.scrollView = scrollView
    self.containerView = cv
  }
  
  func setupUpcomingLaunchesLabel() {
    
    guard let containerView = containerView else { return }
    
    let upcomingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    upcomingLabel.text = "Upcoming Launches"
    upcomingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    
    containerView.addSubview(upcomingLabel)
    
    upcomingLabel.snp.makeConstraints { make in
      make.top.equalTo(containerView.safeAreaLayoutGuide.snp.topMargin).offset(20)
      make.left.equalTo(containerView.snp.left).offset(20)
      make.right.equalTo(containerView.snp.right).offset(-20)
    }
    
    self.upcomingLabel = upcomingLabel
    
  }
  
  func setupPreviousLaunchesLabel() {
    
    guard let containerView = containerView, let upcomingGoCollectionView = upcomingGoCollectionView  else { return }
    
    let previousLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    previousLabel.text = "Previous Launches"
    previousLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    
    containerView.addSubview(previousLabel)
    
    previousLabel.snp.makeConstraints { make in
      make.top.equalTo(upcomingGoCollectionView.safeAreaLayoutGuide.snp.bottomMargin).offset(20)
      make.right.equalTo(containerView.snp.right).offset(-20)
      make.left.equalTo(containerView.snp.left).offset(20)
    }
    
    self.previousLabel = previousLabel
    
  }
  
  func setupUpcomingGoCollectionView() {
    
    setupUpcomingLaunchesLabel()
    
    guard let containerView = containerView, let upcomingLabel = upcomingLabel else { return }
    
    let upcomingGoLaunchesView = UpcomingGoLaunchView()
    upcomingGoLaunchesView.setup()
    upcomingGoLaunchesView.delegate = self
    containerView.addSubview(upcomingGoLaunchesView)
    
    upcomingGoLaunchesView.snp.makeConstraints { make in
      make.left.right.equalTo(containerView)
      make.top.equalTo(upcomingLabel.safeAreaLayoutGuide.snp.bottomMargin).offset(20)
      make.height.equalTo(400)
    }
    
    self.upcomingGoCollectionView = upcomingGoLaunchesView
  }
  
  func setupPreviousLaunchesTableView() {
    
    setupPreviousLaunchesLabel()
    
    guard let containerView = containerView, let previousLabel = previousLabel else { return }
    
    let previousLaunchesView = LaunchTableView()
    previousLaunchesView.setup()
    previousLaunchesView.delegate = self
    containerView.addSubview(previousLaunchesView)
    
    previousLaunchesView.snp.makeConstraints { make in
      make.left.equalTo(self.view)
      make.right.equalTo(self.view)
      make.top.equalTo(previousLabel.safeAreaLayoutGuide.snp.bottomMargin).offset(20)
      make.height.greaterThanOrEqualTo(self.view.bounds.height)
      make.bottom.equalTo(containerView.snp.bottom).offset(0)
    }
    
    self.previousLaunchesTableView = previousLaunchesView
    
  }
}

extension LaunchesView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let yOffset = scrollView.contentOffset.y
    
    if scrollView == self.scrollView {
      print("tableview scroll")
      if yOffset >= scrollView.bounds.height - view.bounds.height {
        print("tableview scroll")
        scrollView.isScrollEnabled = false
        previousLaunchesTableView?.setTableViewScroll(true)
      }
    } else {
      if yOffset <= 0 {
        print("scrollview scroll")
        self.scrollView?.isScrollEnabled = true
        previousLaunchesTableView?.setTableViewScroll(false)
      }
    }
  }
}

extension LaunchesView: LaunchesViewProtocol {
  
  func startLoading() {
    
    isLoading = true
    self.activityIndicator?.isHidden = false
    self.upcomingGoCollectionView?.isHidden = true
    self.activityIndicator?.startAnimating()
    
  }
  
  func stopLoading() {
    
    self.activityIndicator?.stopAnimating()
    self.activityIndicator?.isHidden = true
    self.upcomingGoCollectionView?.isHidden = false
    
  }
  
  func displayUpcomingGoLaunches(_ launches: [LaunchModel]) {
    
    self.upcomingGoCollectionView?.displayUpcomingGoLaunches(launches)
    
  }
  func displayPreviousLaunches(_ launches: [LaunchModel]) {
    
    self.previousLaunchesTableView?.displayPreviousLaunches(launches)
  
  }
  
}

extension LaunchesView: UpcomingGoLaunchViewProtocol {
  
  func didSelectUpcomingGoLaunch(_ launch: LaunchModel) {
    
    self.presenter?.showDetailLaunch(with: launch)
    
  }
}

extension LaunchesView: LaunchTableViewProtocol {
  
  func didSelectLaunch(_ launch: LaunchModel) {
    
    self.presenter?.showDetailLaunch(with: launch)
    
  }
}
