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
        let vm = ProductsListVCViewModel()
        let vc = ProductsListVC(viewModel: vm, loadXib: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
