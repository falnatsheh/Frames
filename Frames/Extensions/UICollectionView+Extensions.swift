import Foundation
import UIKit

extension UICollectionView {
    var visibleCellIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        return indexPathForItem(at: visiblePoint)
    }
    var visibleCell: UICollectionViewCell? {
        guard let indexPath = visibleCellIndexPath else { return nil }
        return cellForItem(at: indexPath)
    }
}
