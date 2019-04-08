
import UIKit

class CustomTVCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dot: UIView!
    
    var updateCallback: (()->())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cellTaped))
        self.contentView.addGestureRecognizer(gesture)
        
        dot.layer.cornerRadius = 25
    }
    
    @objc func cellTaped() {
        dot.backgroundColor = .blue
        self.updateCallback?()
    }
    
}
