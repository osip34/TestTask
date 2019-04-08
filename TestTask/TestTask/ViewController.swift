
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.viewModel.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func SegmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowsCount(for: self.segmentedControl.selectedSegmentIndex) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTVCell", for: indexPath) as? CustomTVCell else {
            return UITableViewCell()
        }
        cell.label.text = self.viewModel.text(for: self.segmentedControl.selectedSegmentIndex, row: indexPath.row)
        cell.dot.backgroundColor = self.viewModel.color(for: self.segmentedControl.selectedSegmentIndex, row: indexPath.row)
        cell.updateCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.changeDotColor(for: strongSelf.segmentedControl.selectedSegmentIndex, row: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteItem(for: self.segmentedControl.selectedSegmentIndex, itemIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

