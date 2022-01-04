import UIKit

extension SelectHandViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countHand
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let handCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HandCell", for: indexPath) as! HandCell
        handCell.handIndex = indexPath.row
        handCell.setCell()
        return handCell
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.restorationIdentifier == "topCollection" {
            topPlayerReady()
        }
        //
        if collectionView.restorationIdentifier == "bottomCollection" {
//            bottomPlayerReady()
            
            (StoreManager.isFullVersion() == false && selectIndexHandBottom > 2) ? showModalFullVersion() : bottomPlayerReady()
        }
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.restorationIdentifier == "topCollection" {
            topPlayerReadyBool = false
            viewSelf.iconTopReady.isHidden = true
        }
        if scrollView.restorationIdentifier == "bottomCollection" {
            bottomPlayerReadyBool = false
            viewSelf.iconBottomReady.isHidden = true
        }
    }
    
    //
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.restorationIdentifier == "topCollection" {
            let visibleRectTop = CGRect(origin: viewSelf.topCollection.contentOffset, size: viewSelf.topCollection.bounds.size)
            let visiblePointTop = CGPoint(x: visibleRectTop.midX, y: visibleRectTop.midY)
            let visibleIndexPathTop = viewSelf.topCollection.indexPathForItem(at: visiblePointTop)
            selectIndexHandTop = visibleIndexPathTop!.row
            checkButtonTop()
        }
        
        if scrollView.restorationIdentifier == "bottomCollection" {
            let visibleRectBottom = CGRect(origin: viewSelf.bottomCollection.contentOffset, size: viewSelf.bottomCollection.bounds.size)
            let visiblePointBottom = CGPoint(x: visibleRectBottom.midX, y: visibleRectBottom.midY)
            let visibleIndexPathBottom = viewSelf.bottomCollection.indexPathForItem(at: visiblePointBottom)
            selectIndexHandBottom = visibleIndexPathBottom!.row
            checkButtonBottom()
        }
    }
}
