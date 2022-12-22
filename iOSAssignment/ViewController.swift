import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var startShoppingButton: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.startShoppingButton.layer.cornerRadius = 5
        self.startShoppingButton.layer.masksToBounds = true
    }
    
    @IBAction func startShoppingTapped(_ sender: Any) {
        self.navigateToProductsList()
    }
    
    public func navigateToProductsList() {
        let vm = StoreListVCViewModel()
        let vc = StoreListVC(viewModel: vm, loadXib: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
