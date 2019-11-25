import UIKit
import AVKit

class VideoPlayerView: UIView {
    private var playerLayer: AVPlayerLayer { return layer as! AVPlayerLayer }
    private var playerLooper: AVPlayerLooper?
    private var player: AVQueuePlayer? {
        get { return playerLayer.player as? AVQueuePlayer }
        set { playerLayer.player = newValue }
    }
    var isPlaying: Bool { player?.rate == 1.0 }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    func resetPlayer() { player = nil }
    
    func play(url: URL) {
        if player != nil { return }
        
        player = AVQueuePlayer()
        let playerItem = AVPlayerItem(url: url)
        playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)

        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.needsDisplayOnBoundsChange = true
        player?.isMuted = true
        player?.play()
    }
    
    func pause() { player?.pause() }
    
    func resume() { player?.play() }
}
