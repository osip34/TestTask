import UIKit
import Foundation

protocol ViewModelP {
    func fetchData(completion: @escaping ()->())
    func deleteItem(for scIndex: Int, itemIndex: Int)
    func rowsCount(for scIndex: Int) -> Int?
    func text(for scIndex: Int, row: Int) -> String?
}

class ViewModel: ViewModelP {
    
    var model: ModelP?
    
    func rowsCount(for scIndex: Int) -> Int? {
        return self.array(for: scIndex)?.count
    }
    
    func text(for scIndex: Int, row: Int) -> String? {
        return self.array(for: scIndex)?[row].text
    }
    
    func color(for scIndex: Int, row: Int) -> UIColor? {
        return self.array(for: scIndex)?[row].color
    }
    
    func changeDotColor(for scIndex: Int, row: Int) {
        switch scIndex {
        case 0: model?.carsArray[row].color = .blue
        case 1: model?.plainsArray[row].color = .blue
        default: break
        }
    }
    
    func fetchData(completion: @escaping ()->()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let cars: [(String, UIColor)] = [("Nissan", .red), ("BMW", .red), ("Ferrari", .red), ("Lada", .red)]
            let plains: [(String, UIColor)] = [("PaperPlain", .red), ("OtherPlain", .red), ("FunnyPlain", .red), ("THIS ONE IS REALLY, REALLY LONG BLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLABLA", .red)]
            self.model = Model(plainsArray: plains, carsArray: cars)
            completion()
        }
    }
    
    func deleteItem(for scIndex: Int, itemIndex: Int) {
        switch scIndex {
        case 0: model?.carsArray.remove(at: itemIndex)
        case 1: model?.plainsArray.remove(at: itemIndex)
        default: break
        }
    }
    
    private func array(for scIndex: Int) -> [(text: String, color: UIColor)]? {
        switch scIndex {
        case 0: return model?.carsArray
        case 1: return model?.plainsArray
        default: return []
        }
    }
}
