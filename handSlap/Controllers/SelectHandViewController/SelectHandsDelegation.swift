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
            if selectIndexHandTop > 2 {
                showModalFullVersion()
            } else {
                topPlayerReady = true
                viewSelf.iconTopReady.isHidden = false
                if topPlayerReady == true && bottomPlayerReady == true {
                    goToGame()
                }
            }
        }
        if collectionView.restorationIdentifier == "bottomCollection" {
            if selectIndexHandBottom > 2 {
                showModalFullVersion()
            } else {
                bottomPlayerReady = true
                viewSelf.iconBottomReady.isHidden = false
                if topPlayerReady == true && bottomPlayerReady == true {
                    self.goToGame()
                }
            }
        }
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.restorationIdentifier == "topCollection" {
            topPlayerReady = false
            viewSelf.iconTopReady.isHidden = true
        }

        if scrollView.restorationIdentifier == "bottomCollection" {
            bottomPlayerReady = false
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
