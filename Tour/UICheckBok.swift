import Foundation
import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = #imageLiteral(resourceName: "ic_check_box_white");
    //let check = checkedImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    let uncheckedImage = #imageLiteral(resourceName: "ic_check_box_outline_blank_white");
    //let unCheck = uncheckedImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            let check = checkedImage.withRenderingMode(.alwaysTemplate)
            let unCheck = uncheckedImage.withRenderingMode(.alwaysTemplate)
            if isChecked == true {
                self.setImage(check, for: .normal)
            } else {
                self.setImage(unCheck, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
