import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet var todoTitle: UILabel!
    
    @IBOutlet var time: UILabel!
    
    var importance : Int = 0
}
