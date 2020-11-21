//
//  LaunchTableViewCell.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 18/11/20.
//

import UIKit
import SDWebImage

class LaunchTableViewCell: UITableViewCell {

  @IBOutlet weak var launchImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  func set(_ launch: LaunchModel) {
    titleLabel.text = launch.name
    statusLabel.text = launch.status.name
    dateLabel.text = launch.net
    if !launch.image.isEmpty {
      launchImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
      launchImageView.sd_setImage(with: URL(string: launch.image))
    }
  }
    
}
