import UIKit

class MenuGameViewController: GeneralViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sound(_ sender: Any) {
        print("SOUND")
    }
    
    @IBAction func vibration(_ sender: Any) {
        print("VIBRATION")
    }
    
    @IBAction func restartRound(_ sender: Any) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: self.nReloadRound, object: nil)
        }
    }

    @IBAction func home(_ sender: Any) {
        dismiss(animated: false) {
            NotificationCenter.default.post(name: self.nBackHome, object: self)
        }
    }
    
    @IBAction func backToGame(_ sender: Any) {
        dismiss(animated: false)
    }
}
