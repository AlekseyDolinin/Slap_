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
    var listHand = [Hand]()

    //
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.topCollection.delegate = self
        viewSelf.topCollection.dataSource = self
        viewSelf.bottomCollection.delegate = self
        viewSelf.bottomCollection.dataSource = self
        for i in 0..<10 {
            listHand.append(Hand(id: i, name: "hand_0"))
            viewSelf.listHand = self.listHand
        }
        ///
        NotificationCenter.default.addObserver(forName: nTransactionComplate, object: nil, queue: nil) { notification in
            print("nTransactionComplate")
            self.dismiss(animated: true) {
//                self.navigationController?.popViewController(animated: true)
                self.reloadAfterTransactionComplate()
            }
        }
        
        print("is full version: \(StoreManager.isFullVersion())")
    }
    
    func reloadAfterTransactionComplate() {
        viewSelf.topCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        viewSelf.bottomCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        viewSelf.topSelectButton.setTitle("Ready", for: .normal)
        viewSelf.bottomSelectButton.setTitle("Ready", for: .normal)
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
            vc.topHand = self.listHand[self.selectIndexHandTop]
            vc.bottomHand = self.listHand[self.selectIndexHandBottom]
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
    
    //
    @IBAction func topPlayerReadyAction() {
        topPlayerReady()
    }
        
    //
    @IBAction func bottomPlayerReadyAction() {
        bottomPlayerReady()
    }
    
    ///
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //
    @IBAction func scrollTopHand(_ sender: UIButton) {
        if sender.restorationIdentifier == "PreviousHandTop" {
            selectIndexHandTop = selectIndexHandTop - 1
            if !(0..<listHand.count).contains(selectIndexHandTop) {
                print("out")
                selectIndexHandTop += 1
            }
        }
        if sender.restorationIdentifier == "NextHandTop" {
            selectIndexHandTop = selectIndexHandTop + 1
            if !(0..<listHand.count).contains(selectIndexHandTop) {
                print("out")
                selectIndexHandTop -= 1
            }
        }
        viewSelf.topCollection.scrollToItem(at: IndexPath(row: selectIndexHandTop, section: 0),
                                      at: .centeredHorizontally, animated: true)
        // показ и скрытие переключателей рук
        // при крайних положениях скрываются кнопки далее
        viewSelf.checkButton(indexHandTop: selectIndexHandTop, indexHandBottom: selectIndexHandBottom)
    }
    
    //
    @IBAction func scrollBottomHand(_ sender: UIButton) {
        if sender.restorationIdentifier == "PreviousHandBottom" {
            selectIndexHandBottom = selectIndexHandBottom - 1
            if !(0..<listHand.count).contains(selectIndexHandBottom) {
                print("out")
                selectIndexHandBottom += 1
            }
        }
        
        if sender.restorationIdentifier == "NextHandBottom" {
            selectIndexHandBottom = selectIndexHandBottom + 1
            if !(0..<listHand.count).contains(selectIndexHandBottom) {
                print("out")
                selectIndexHandBottom -= 1
            }
        }
        viewSelf.bottomCollection.scrollToItem(at: IndexPath(row: selectIndexHandBottom, section: 0),
                                      at: .centeredHorizontally, animated: true)
        // показ и скрытие переключателей рук
        // при крайних положениях скрываются кнопки далее
        viewSelf.checkButton(indexHandTop: selectIndexHandTop, indexHandBottom: selectIndexHandBottom)
    }
}
