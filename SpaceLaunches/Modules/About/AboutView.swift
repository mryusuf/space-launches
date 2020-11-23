//
//  AboutView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit
import SnapKit

protocol AboutViewProtocol: class {
  
  var presenter: AboutPresenterProtocol? { get set }
  func display(_ model: AboutModel)
  
}

class AboutView: UIViewController {
  
  var presenter: AboutPresenterProtocol?
  
  init() {
      super.init(nibName: nil, bundle: nil)
      
      self.title = "About"
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
    self.presenter?.setupView()
  }
  
  override func viewDidLoad() {
    self.view.backgroundColor = .white
  }
}

extension AboutView: AboutViewProtocol {
  
  func display(_ model: AboutModel) {
    
    let aboutImageView = UIImageView()
    aboutImageView.image = UIImage(named: model.imageName)
    aboutImageView.contentMode = .scaleAspectFit
    
    self.view.addSubview(aboutImageView)
    
    aboutImageView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(0)
      make.left.right.equalToSuperview()
      make.height.equalTo(200)
    }
    
    let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    nameLabel.text = model.name
    nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    self.view.addSubview(nameLabel)
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(aboutImageView.safeAreaLayoutGuide.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
    }
    
    let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    emailLabel.text = model.email
    
    self.view.addSubview(emailLabel)
    
    emailLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp_bottomMargin).offset(8)
      make.centerX.equalToSuperview()
    }
  
 }
  
}
