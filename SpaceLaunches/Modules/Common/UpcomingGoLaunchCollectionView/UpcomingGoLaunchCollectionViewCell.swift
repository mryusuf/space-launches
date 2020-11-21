//
//  UpcomingGoCollectionViewCell.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 16/11/20.
//

import UIKit
import SDWebImage

class UpcomingGoLaunchCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var launchDateLabel: UILabel!
  @IBOutlet weak var agencyLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
//    print("awakeFromNib")
  }
  
  func set(_ launch: LaunchModel) {
    
//    print("UpcomingGoCollectionViewCell set \(launch.image)")
    titleLabel.text = launch.name
    launchDateLabel.text = launch.net
    agencyLabel.text = launch.agency.name
    if !launch.image.isEmpty {
      imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
      imageView.sd_setImage(with: URL(string: launch.image))
    }
    
  }

}
