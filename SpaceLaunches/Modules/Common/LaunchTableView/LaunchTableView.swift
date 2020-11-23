//
//  PreviousLaunchView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 18/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

protocol LaunchTableViewProtocol: class {
  
  func didSelectLaunch(_ launch: LaunchModel)
  
}

class LaunchTableView: UIView {

  private weak var launchesTableView: UITableView?
  private let cellName = "LaunchTableViewCell"
  private var launches: [LaunchModel] = []
  private var launchSections: [LaunchSection] = []
  private var launchesDataSource: RxTableViewSectionedReloadDataSource<LaunchSection>?
  private var launchesSubject: PublishSubject<[LaunchSection]>?
  private var isLoading = false
  private var bags = DisposeBag()
  weak var delegate: LaunchTableViewProtocol?
  
  private func loadLaunchSection() -> [LaunchSection] {
    
    let header = "Launches"
    
    let sections = [LaunchSection(header: header, items: launches)]
    self.launchSections = sections
    return sections
  }
  
}

extension LaunchTableView {
  
  func setup() {
    setupTableView()
    setupRxDataSource()
  }
  
  private func setupTableView() {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = .clear
    tableView.tableFooterView = UIView()
    tableView.rx.setDelegate(self).disposed(by: bags)
    tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    addSubview(tableView)
    
    let top = CGFloat(0)
    tableView.contentInset = UIEdgeInsets(top: top, left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.center.equalToSuperview()
    }
    
    self.launchesTableView = tableView
  }
  
  private func setupRxDataSource() {
    guard let launchesTableView = launchesTableView else { return }
    let subject = PublishSubject<[LaunchSection]>()
    let dataSource = RxTableViewSectionedReloadDataSource<LaunchSection>(
      configureCell: { _, tableView, indexPath, item in
        
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) as? LaunchTableViewCell
          else { return UITableViewCell() }
        cell.set(item)
        return cell
        
      }
    )
    
    subject
      .bind(to: launchesTableView.rx.items(dataSource: dataSource))
      .disposed(by: bags)
    self.launchesSubject = subject
    self.launchesDataSource = dataSource
    
  }
    
  func displayPreviousLaunches(_ launches: [LaunchModel]) {
    
    guard !isLoading, let launchesSubject = launchesSubject else { return }
    isLoading = true
    self.launches = launches
    launchesSubject.onNext(loadLaunchSection())
    isLoading = false
    
  }
  
  func setTableViewScroll(_ isEnabled: Bool) {
    self.launchesTableView?.isScrollEnabled = isEnabled
  }
  
}

extension LaunchTableView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let launchesDataSource = launchesDataSource else {
      return
    }
    let selectedLaunch = launchesDataSource[indexPath]
    self.delegate?.didSelectLaunch(selectedLaunch)
    
  }
}
