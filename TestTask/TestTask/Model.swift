import UIKit

protocol ModelP {
    var plainsArray: [(text: String, color: UIColor)] {get set}
    var carsArray: [(text: String, color: UIColor)] {get set}
    
}

struct Model: ModelP {
    var plainsArray: [(text: String, color: UIColor)]
    var carsArray: [(text: String, color: UIColor)]
    
}
