import Foundation
import UIKit

class PlayerCell: UICollectionViewCell {
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playButton.isSelected = false
        playerView.resetPlayer()
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        playButton.isSelected = !playButton.isSelected
        playerView.isPlaying ? playerView.pause() : playerView.resume()
    }
}
