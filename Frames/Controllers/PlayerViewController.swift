import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    var videos: [Video] = []
    var initialVideoIndex: Int?
    private var didScrollToInitialVideo = false
    @IBOutlet weak var collectionView: UICollectionView!
    
    func playVisibleCellVideo() {
        let playerCell = collectionView.visibleCell as? PlayerCell
        if let row = collectionView.visibleCellIndexPath?.row {
            playerCell?.playerView?.play(url: videos[row].videoUrl)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func scrollToInitialVideo() {
        guard let initialVideoIndex = initialVideoIndex else {  return }
        let scrollIndex = IndexPath(item: initialVideoIndex, section: 0)
        collectionView.scrollToItem(at: scrollIndex, at: .left, animated: false)
        
        self.collectionView.performBatchUpdates(nil, completion: { _ in
            self.playVisibleCellVideo()
        })
        
        didScrollToInitialVideo = true
    }
}

extension PlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let playerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCell
        playerCell.videoTitle.text = videos[indexPath.row].title
        return playerCell
    }
    
}

extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height - 50)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playVisibleCellVideo()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !didScrollToInitialVideo {
            scrollToInitialVideo()
        }
    }
}
