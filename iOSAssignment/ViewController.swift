import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
