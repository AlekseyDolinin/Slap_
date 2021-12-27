import UIKit

extension SelectHandViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listHand.count
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let handCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HandCell", for: indexPath) as! HandCell
        handCell.hand = listHand[indexPath.row]
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
            bottomPlayerReady()
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
        let visibleRectTop = CGRect(origin: viewSelf.topCollection.contentOffset, size: viewSelf.topCollection.bounds.size)
        let visiblePointTop = CGPoint(x: visibleRectTop.midX, y: visibleRectTop.midY)
        let visibleIndexPathTop = viewSelf.topCollection.indexPathForItem(at: visiblePointTop)
        selectIndexHandTop = visibleIndexPathTop!.row
        
        let visibleRectBottom = CGRect(origin: viewSelf.bottomCollection.contentOffset, size: viewSelf.bottomCollection.bounds.size)
        let visiblePointBottom = CGPoint(x: visibleRectBottom.midX, y: visibleRectBottom.midY)
        let visibleIndexPathBottom = viewSelf.bottomCollection.indexPathForItem(at: visiblePointBottom)
        selectIndexHandBottom = visibleIndexPathBottom!.row
        // показ и скрытие переключателей рук
        // при крайних положениях скрываются кнопки далее
        viewSelf.checkButton(indexHandTop: selectIndexHandTop, indexHandBottom: selectIndexHandBottom)
        
        viewSelf.selectIndexHandTop = self.selectIndexHandTop
        viewSelf.selectIndexHandBottom = self.selectIndexHandBottom
        viewSelf.setContent()
    }
}
