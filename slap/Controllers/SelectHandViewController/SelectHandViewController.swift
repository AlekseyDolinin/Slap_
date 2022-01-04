import UIKit

class SelectHandViewController: GeneralViewController {
    
    var viewSelf: SelectHandView! {
        guard isViewLoaded else {return nil}
        return (view as! SelectHandView)
    }
    
    var selectIndexHandTop = 0
    var selectIndexHandBottom = 0
    var topPlayerReadyBool = false
    var bottomPlayerReadyBool = false
    var countHand = 7

    //
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.topCollection.delegate = self
        viewSelf.topCollection.dataSource = self
        viewSelf.bottomCollection.delegate = self
        viewSelf.bottomCollection.dataSource = self

        viewSelf.countHand = self.countHand
        
        //
        NotificationCenter.default.addObserver(forName: nTransactionComplate, object: nil, queue: nil) { notification in
            print("nTransactionComplate")
            self.dismiss(animated: true) {
                self.reloadAfterTransactionComplate()
            }
        }
        print("is full version: \(StoreManager.isFullVersion())")
    }
    
    //
    func reloadAfterTransactionComplate() {
        viewSelf.topCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        viewSelf.bottomCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        selectIndexHandTop = 0
        selectIndexHandBottom = 0
        topPlayerReadyBool = false
        bottomPlayerReadyBool = false
        viewSelf.topCollection.reloadData()
        viewSelf.bottomCollection.reloadData()
    }
    
    //
    func goToGame() {
        viewSelf.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            vc.topHandIndex = self.selectIndexHandTop
            vc.bottomHandIndex = self.selectIndexHandBottom
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //
    func showModalFullVersion() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullVersionViewController") as! FullVersionViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    //
    func topPlayerReady() {
        if StoreManager.isFullVersion() == false && selectIndexHandTop > 2 {
            showModalFullVersion() // показ модалки о покупке
        } else { // select hand
            topPlayerReadyBool = true
            viewSelf.iconTopReady.isHidden = false
            if topPlayerReadyBool == true && bottomPlayerReadyBool == true {
                goToGame()
            }
        }
    }
    
    //
    func bottomPlayerReady() {
        if StoreManager.isFullVersion() == false  && selectIndexHandBottom > 2 {
            showModalFullVersion() // показ модалки о покупке
        } else { // select hand
            bottomPlayerReadyBool = true
            viewSelf.iconBottomReady.isHidden = false
            if topPlayerReadyBool == true && bottomPlayerReadyBool == true {
                goToGame()
            }
        }
    }
    
    ///
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //
    func checkButtonTop() {
        viewSelf.iconTopReady.isHidden = selectIndexHandTop > 2 ? false : true
        viewSelf.iconTopReady.image = UIImage(named: selectIndexHandTop > 2 ? "lockIcon" : "checkIcon")
        viewSelf.topCollectionPreviousButton.alpha = selectIndexHandTop == 0 ? 0.2 : 1
        viewSelf.topCollectionNextButton.alpha = selectIndexHandTop == (countHand - 1) ? 0.2 : 1
    }
    
    //
    func checkButtonBottom() {
        viewSelf.iconBottomReady.isHidden = selectIndexHandBottom > 2 ? false : true
        viewSelf.iconBottomReady.image = UIImage(named: selectIndexHandBottom > 2 ? "lockIcon" : "checkIcon")
        viewSelf.bottomCollectionPreviousButton.alpha = selectIndexHandBottom == 0 ? 0.2 : 1
        viewSelf.bottomCollectionNextButton.alpha = selectIndexHandBottom == (countHand - 1) ? 0.2 : 1
    }
}
