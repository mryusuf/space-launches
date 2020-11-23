//
//  UpcomingGoCollectionViewCell.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 16/11/20.
//

import UIKit
import SDWebImage
import RxSwift

class UpcomingGoLaunchCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var launchDateLabel: UILabel!
  @IBOutlet weak var agencyLabel: UILabel!
  @IBOutlet weak var countdownLabel: UILabel!
  @IBOutlet weak var tLabel: UILabel!
  @IBOutlet weak var countdownLegendLabel: UILabel!
  private var net: Date?
  let calendar = Calendar.current
  private var bags = DisposeBag()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func set(_ launch: LaunchModel) {
    
    titleLabel.text = launch.name
    launchDateLabel.text = launch.net
    agencyLabel.text = launch.agency.name
    if !launch.image.isEmpty {
      imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
      imageView.sd_setImage(with: URL(string: launch.image))
    }
    
    if let net = launch.net.modelToDate() {
      self.countdownLabel.font = .monospacedDigitSystemFont(ofSize: 24, weight: .bold)
      self.net = net
      Observable<Int>
        .interval(.seconds(1), scheduler: MainScheduler.instance)
        .subscribe(onNext: { _ in
          if self.checkIfNetIsNow() {
            self.countdownLabel.text = "Launch !"
            self.tLabel.isHidden = true
            self.countdownLegendLabel.isHidden = true
          } else {
            self.countdownLabel.text = self.setCountDownString()
          }
        })
        .disposed(by: bags)
    
    }
  }
  
  func checkIfNetIsNow() -> Bool {
    guard let net = net else { return false}
    let diff = calendar.compare(Date(), to: net, toGranularity: .second)
    return diff == .orderedSame
  }
  
  func setCountDownString() -> String {
    guard let net = net else { return "" }
    
    let countdownDate = calendar.dateComponents(
      [.day, .hour, .minute, .second],
      from: Date(),
      to: net
    )
    
    let day = countdownDate.day?.description ?? ""
    let hours = countdownDate.hour?.description ?? ""
    let minutes = countdownDate.minute?.description ?? ""
    let seconds = countdownDate.second?.description ?? ""
    return "\(day)   : \(hours)   : \(minutes)   : \(seconds)"
  }

}
