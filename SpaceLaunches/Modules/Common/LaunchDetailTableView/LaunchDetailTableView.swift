//
//  LaunchDetailTableView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 19/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class LaunchDetailTableView: UIView {

  private var launchDetailTableView: UITableView?
  private let cellName = "LaunchDetailDescTableViewCell"
  private let infographicCellName = "LaunchDetailInfographicTableViewCell"
  private var launchDescDetails: [LaunchDetail] = []
  private var launchInfographicDetails: [LaunchDetail] = []
  private var launchSections: [LaunchDetailSection] = []
  private var launchDetailDataSource: RxTableViewSectionedReloadDataSource<LaunchDetailSection>?
  private var launchDetailSubject: PublishSubject<[LaunchDetailSection]>?
  private var isLoading = false
  private var bags = DisposeBag()
  private weak var presenter: LaunchDetailPresenterProtocol?

  private func loadLaunchSection() -> [LaunchDetailSection] {
    
    let descHeader = "Description"
    
    var sections = [
      LaunchDetailSection(
        header: descHeader,
        items: launchDescDetails)
    ]
    if launchInfographicDetails.count > 0 {
      sections.append(LaunchDetailSection(
                        header: launchInfographicDetails.first?.label ?? "",
                        items: launchInfographicDetails))
    }
    self.launchSections = sections
    return sections
  }
  
}

extension LaunchDetailTableView {
  
  func setup(presenter: LaunchDetailPresenterProtocol) {
    self.presenter = presenter
    setupTableView()
    setupRxDataSource()
  }
  
  private func setupTableView() {
    
    let tableView = UITableView(frame: .zero)
    tableView.backgroundColor = .clear
    tableView.isPagingEnabled = true
    tableView.showsVerticalScrollIndicator = false
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.rx.setDelegate(self).disposed(by: bags)
    tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    tableView.register(UINib(nibName: infographicCellName, bundle: nil), forCellReuseIdentifier: infographicCellName)
    addSubview(tableView)
    
    let top = CGFloat(0)
    tableView.contentInset = UIEdgeInsets(top: top, left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.center.equalToSuperview()
    }
    
    self.launchDetailTableView = tableView
  }
  
  private func setupRxDataSource() {
    guard let launchDetailTableView = launchDetailTableView else { return }

    let subject = PublishSubject<[LaunchDetailSection]>()
    let dataSource = RxTableViewSectionedReloadDataSource<LaunchDetailSection>(
      configureCell: { _, tableView, _, item in
        
        if item.label == "Infographic" {
          return self.buildInfographicCell(with: item, from: tableView)
        } else {
          return self.buildDescCell(with: item, from: tableView)
        }
        
      }
    )
    
    dataSource.titleForHeaderInSection = { dataSource, index in
      return dataSource.sectionModels[index].header
    }
    
    subject
      .bind(to: launchDetailTableView.rx.items(dataSource: dataSource))
      .disposed(by: bags)
    self.launchDetailSubject = subject
    self.launchDetailDataSource = dataSource
    
  }
  
  private func buildDescCell(with launchDetail: LaunchDetail, from tableView: UITableView) -> UITableViewCell {
    
    guard let cell = tableView
            .dequeueReusableCell(withIdentifier: self.cellName) as? LaunchDetailDescTableViewCell
      else { return UITableViewCell() }
     cell.set(launchDetail)
    return cell
    
  }
  
  private func buildInfographicCell(with launchDetail: LaunchDetail, from tableView: UITableView) -> UITableViewCell {
    
    guard let cell = tableView
            .dequeueReusableCell(withIdentifier: self.infographicCellName) as? LaunchDetailInfographicTableViewCell,
          let presenter = presenter
      else { return UITableViewCell() }
     cell.set(launchDetail, presenter: presenter)
    return cell
    
  }
  
  func displayDetailLaunch(_ launchDescDetails: [LaunchDetail], _ launchInfographicDetails: [LaunchDetail]) {
    
    guard !isLoading, let launchesSubject = launchDetailSubject else { return }
    isLoading = true
    self.launchDescDetails = launchDescDetails
    self.launchInfographicDetails = launchInfographicDetails
    launchesSubject.onNext(loadLaunchSection())
    isLoading = false
    
  }
  
}

extension LaunchDetailTableView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let header = launchDetailDataSource?[indexPath].label, header == "Infographic" {
      return CGFloat(300)
    } else {
      return UITableView.automaticDimension
    }
  }
}
