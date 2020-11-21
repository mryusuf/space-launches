//
//  LaunchDetailDescTableViewCell.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 19/11/20.
//

import UIKit

class LaunchDetailDescTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func set(_ launchDetail: LaunchDetail) {
    nameLabel.text = launchDetail.label
    detailLabel.text = launchDetail.detail
  }
  
}
