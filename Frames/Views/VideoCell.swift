import Foundation

import UIKit
import AVKit
class VideoCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.isSelected = false
        activityIndicator.startAnimating()
        playerView.resetPlayer()
    }
}
