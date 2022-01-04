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
    var countHand = 0
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountHands()
        
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
    func getCountHands() {
        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: Bundle.main.resourcePath!)
            for item in items {
                if item.prefix(5) == "hand_" && item.suffix(4) == ".png" {
                    countHand += 1
                }
            }
        } catch {
            print("failed to read directory")
        }
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
        bottomPlayerReadyBool = true
        viewSelf.iconBottomReady.isHidden = false
        if topPlayerReadyBool == true && bottomPlayerReadyBool == true {
            goToGame()
        }
    }
    
    ///
    @IBAction func topHandPrew(_ sender: Any) {
        if selectIndexHandTop == 0 {return}
        selectIndexHandTop = selectIndexHandTop - 1
        viewSelf.topCollection.scrollToItem(at: IndexPath(item: selectIndexHandTop, section: 0),
                                            at: .centeredHorizontally,
                                            animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewSelf.checkButtonTop(selectIndexHandTop: self.selectIndexHandTop)
        }
    }
    
    ///
    @IBAction func topHandNext(_ sender: Any) {
        if selectIndexHandTop == (countHand - 1) {return}
        selectIndexHandTop = selectIndexHandTop + 1
        viewSelf.topCollection.scrollToItem(at: IndexPath(item: selectIndexHandTop, section: 0),
                                            at: .centeredHorizontally,
                                            animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewSelf.checkButtonTop(selectIndexHandTop: self.selectIndexHandTop)
        }
    }
    
    ///
    @IBAction func bottomHandPrew(_ sender: Any) {
        if selectIndexHandBottom == 0 {return}
        selectIndexHandBottom = selectIndexHandBottom - 1
        viewSelf.bottomCollection.scrollToItem(at: IndexPath(item: selectIndexHandBottom, section: 0),
                                               at: .centeredHorizontally,
                                               animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewSelf.checkButtonBottom(selectIndexHandBottom: self.selectIndexHandBottom)
        }
    }
    
    ///
    @IBAction func bottomHandNext(_ sender: Any) {
        if selectIndexHandBottom == (countHand - 1) {return}
        selectIndexHandBottom = selectIndexHandBottom + 1
        viewSelf.bottomCollection.scrollToItem(at: IndexPath(item: selectIndexHandBottom, section: 0),
                                               at: .centeredHorizontally,
                                               animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewSelf.checkButtonBottom(selectIndexHandBottom: self.selectIndexHandBottom)
        }
    }
    
    ///
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
