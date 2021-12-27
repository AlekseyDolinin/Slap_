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
    
    @IBAction func getFullVersion(_ sender: Any) {
 
    }

    @IBAction func restorePurshase(_ sender: Any) {

    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false)
    }
}
