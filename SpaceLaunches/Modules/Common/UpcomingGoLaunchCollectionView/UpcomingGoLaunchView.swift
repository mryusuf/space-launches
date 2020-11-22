//
//  UpcomingGoLaunchView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 16/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

protocol UpcomingGoLaunchViewProtocol: class {
  
  func didSelectUpcomingGoLaunch(_ launch: LaunchModel)
  
}

class UpcomingGoLaunchView: UIView {

  private weak var launchesCollectionView: UICollectionView?
  private let cellName = "UpcomingGoCollectionCell"
  private var launches: [LaunchModel] = []
  private var launchSections: [LaunchSection] = []
  private var launchesDataSource: RxCollectionViewSectionedReloadDataSource<LaunchSection>?
  private var launchesSubject: PublishSubject<[LaunchSection]>?
  private var isLoading = false
  private var bags = DisposeBag()
  weak var delegate: UpcomingGoLaunchViewProtocol?
  
  private func loadLaunchSection() -> [LaunchSection] {
    
    let header = "Launches"
    
    let sections = [LaunchSection(header: header, items: launches)]
    self.launchSections = sections
    return sections
  }
  
}

extension UpcomingGoLaunchView {
  
  func setup() {
    setupCollectionView()
    setupRxDataSource()
  }
  
  private func setupCollectionView() {
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.isPagingEnabled = true
    collectionView.rx.setDelegate(self).disposed(by: bags)
    collectionView.register(UINib(nibName: "UpcomingGoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellName)
    addSubview(collectionView)
    
    let top = CGFloat(0)
    collectionView.contentInset = UIEdgeInsets(top: top, left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.center.equalToSuperview()
    }
    
    self.launchesCollectionView = collectionView
  }
  
  private func setupRxDataSource() {
    guard let launchesCollectionView = launchesCollectionView else { return }
    let subject = PublishSubject<[LaunchSection]>()
    let dataSource = RxCollectionViewSectionedReloadDataSource<LaunchSection>(
      configureCell: { _, collectionView, indexPath, item in
        
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: self.cellName, for: indexPath) as? UpcomingGoLaunchCollectionViewCell
          else { return UICollectionViewCell() }
        cell.set(item)
        return cell
        
      }
    )
    
    subject
      .bind(to: launchesCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: bags)
    
    self.launchesSubject = subject
    self.launchesDataSource = dataSource
    
  }
    
  func displayUpcomingGoLaunches(_ launches: [LaunchModel]) {
    
    guard !isLoading, let launchesSubject = launchesSubject else { return }
//    print("UpcomingGoCollectionView displayUpcomingGoLaunches")
    isLoading = true
    self.launches = launches
    launchesSubject.onNext(loadLaunchSection())
    isLoading = false
    
  }
}

extension UpcomingGoLaunchView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let launchesDataSource = launchesDataSource else { return }
    let selectedLaunch = launchesDataSource[indexPath]
    delegate?.didSelectUpcomingGoLaunch(selectedLaunch)
    
  }
  
}

extension UpcomingGoLaunchView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
      
    let width = CGFloat(335 - 20)
    let height = collectionView.bounds.size.height - 16
    return CGSize( width: width, height: height )
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(16)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 8, left: 20, bottom: 8, right: 8)
  }
}
