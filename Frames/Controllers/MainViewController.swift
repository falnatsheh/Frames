import UIKit
import AVFoundation

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let coverrClient = CoverrClient()
    private var videos: [Video] = []
    private let favoriteDao = FavoriteDao()
    private var visibleCellIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        return collectionView.indexPathForItem(at: visiblePoint)
    }
    private var visibleCell: VideoCell? {
        guard let indexPath = visibleCellIndexPath else { return nil }
        return collectionView.cellForItem(at: indexPath) as? VideoCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverrClient.fetchVideos(completion: { videos, error  in
            if videos.count == 0 { return }
            self.videos = videos
            DispatchQueue.main.async{
                self.collectionView.reloadData()
                
                // Play the visible player after reload is done.
                self.collectionView.performBatchUpdates(nil, completion: { _ in self.playVisibleCellVideo() })
            }
        })
    }
    
    func playVisibleCellVideo() {
        let videoCell = self.visibleCell
        videoCell?.activityIndicator.stopAnimating()
        videoCell?.playerView?.play(url: videos[visibleCellIndexPath!.row].videoUrl)
    }
    
    @objc func favoriteButtonTapped(button : UIButton){
        let isFavorite = !button.isSelected
        let id = videos[button.tag].id
        if favoriteDao.saveFavorite(id: id, isFavorite: isFavorite) {
            button.isSelected = isFavorite
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        videoCell.titleLabel.text =  videos[indexPath.row].title
        
        videoCell.favoriteButton.isSelected = favoriteDao.isFavorite(id: videos[indexPath.row].id)
        videoCell.favoriteButton.tag = indexPath.row
        videoCell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return videoCell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let playerViewController : PlayerViewController = mainStoryboard.instantiateViewController(withIdentifier: "playerViewController") as! PlayerViewController
        playerViewController.video = videos[indexPath.row]
        self.present(playerViewController, animated: true, completion: nil)
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(600))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        playVisibleCellVideo()
    }
}
