//
//  LaunchDetailInfographicTableViewCell.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 19/11/20.
//

import UIKit
import SDWebImage

class LaunchDetailInfographicTableViewCell: UITableViewCell {

  @IBOutlet weak var infographicImageView: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func set(_ launchDetail: LaunchDetail) {
    print("set LaunchDetail Infographic")
    infographicImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
    infographicImageView.sd_setImage(with: URL(string: launchDetail.detail))
  }
    
}
