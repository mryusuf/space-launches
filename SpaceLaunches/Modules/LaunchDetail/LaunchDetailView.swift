//
//  LaunchView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit
import RxSwift
import SDWebImage
import SnapKit

protocol LaunchDetailViewProtocol: class {
  
  var presenter: LaunchDetailPresenterProtocol? { get set }
  func displayLaunch(name: String, image: String, desc: [LaunchDetail], infographic: [LaunchDetail])
  func updateToggleWatchlist(isInWatchlist: Bool)
  
}

class LaunchDetailView: UIViewController {
  
  var presenter: LaunchDetailPresenterProtocol?
  private weak var launchImageView: UIImageView?
  private  weak var detailTableView: LaunchDetailTableView?
  private  weak var titleLabel: UILabel?
  private  weak var agencyLabel: UILabel?
  private  weak var launchDateLabel: UILabel?
  private  weak var addToWatchlistButton: UIButton?
  private var isInWatchlist = false
  init() {
      super.init(nibName: nil, bundle: nil)
      
      self.title = "Space Launch"
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    self.view.backgroundColor = .systemBackground
//    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemFill]
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.hidesBarsOnSwipe = false
    
    self.presenter?.loadDetailLaunch()
    
    let isInWatchlist = self.presenter?.checkIfInWatchlist() ?? false
    
    let addToWatchlistButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
    addToWatchlistButton.setImage(
      UIImage(systemName: isInWatchlist ? "binoculars.fill" : "binoculars"),
      for: .normal)
    addToWatchlistButton.addTarget(self, action: #selector(toggleWatchlist), for: .touchUpInside)
    
    self.addToWatchlistButton = addToWatchlistButton
    let rightBarButtonItem = UIBarButtonItem(customView: addToWatchlistButton)
    self.navigationItem.rightBarButtonItem = rightBarButtonItem
    
  }
  
}

extension LaunchDetailView {
  
  @objc func toggleWatchlist() {
    self.presenter?.toggleWatchlist()
  }
}

extension LaunchDetailView: LaunchDetailViewProtocol {
  
  func displayLaunch(name: String, image: String, desc: [LaunchDetail], infographic: [LaunchDetail]) {
//    self.title = launch.name
    
    let launchImageView = UIImageView()
    launchImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
    launchImageView.sd_setImage(with: URL(string: image))
    
    self.view.addSubview(launchImageView)
    launchImageView.snp.makeConstraints { make in
      make.left.right.equalTo(self.view)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(0)
      make.width.equalToSuperview()
      make.height.equalTo(250)
    }
    self.launchImageView = launchImageView
    
    let launchDetailTableView = LaunchDetailTableView()
    launchDetailTableView.setup()
    launchDetailTableView.displayDetailLaunch(desc, infographic)
    self.view.addSubview(launchDetailTableView)
    
    launchDetailTableView.snp.makeConstraints { make in
      make.top.equalTo(launchImageView.snp_bottomMargin).offset(10)
      make.left.right.equalTo(self.view)
      make.bottom.equalTo(self.view).offset(0)
    }
    
  }
  
  func updateToggleWatchlist(isInWatchlist: Bool) {
    print("LaunchDetailView updateToggleWatchlist \(isInWatchlist)")
    self.addToWatchlistButton?.setImage(
      UIImage(systemName: isInWatchlist ? "binoculars.fill" : "binoculars"),
      for: .normal)
  }
  
}
