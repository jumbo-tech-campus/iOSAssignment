//
//  TableView.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class TableView: UITableView, HasDisposeBag {
    var disposeBag = DisposeBag()
    private var _viewModel: ViewModel!
    var _refreshControl: UIRefreshControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Make sure to `trackActivityIndicator` or trigger endRefreshing manually
    func addRefreshControl(refControl: UIRefreshControl = UIRefreshControl()) {
        _refreshControl = refControl
        _refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl = _refreshControl
    }
    
    func endRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self._refreshControl?.endRefreshing()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        endRefreshing()
    }
    
    func setPrivateViewModel(_ viewModel: ViewModel) {
        _viewModel = viewModel
    }
}

extension TableView: Refreshable {
    @objc open func refresh() {
        
    }
}

extension TableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}

extension UITableView {
    func registerCells<T> (cells : [T.Type]) where T: TableViewCell  {
        for cell in cells  {
            let nib = UINib(nibName: String(describing: cell), bundle: nil)
            register(nib, forCellReuseIdentifier: String(describing: cell))
        }
    }
}

// MARK: - To check if indexPath is valid or not
extension TableView {
    func isValidIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

// MARK: - Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
