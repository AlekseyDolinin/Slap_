import UIKit

class MenuAppViewController: GeneralViewController {

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
 
    }

    @IBAction func home(_ sender: Any) {

    }
    
    @IBAction func backToGame(_ sender: Any) {
        dismiss(animated: false)
    }
}
