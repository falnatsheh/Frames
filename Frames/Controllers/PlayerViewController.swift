import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let video = video else {
            return
        }
        videoTitle.text = video.title
        playerView.play(url: video.videoUrl)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        playButton.isSelected = !playButton.isSelected
        playerView.isPlaying ? playerView.pause() : playerView.resume()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
