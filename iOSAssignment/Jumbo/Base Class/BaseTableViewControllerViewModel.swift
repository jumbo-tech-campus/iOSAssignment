//
//  BaseTableViewControllerViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//


import Foundation
import RxDataSources
import RxSwift
import RxCocoa

class BaseTableViewControllerViewModel: ViewModel {
    
    var sectionsModels: Driver<[TableViewSectionModel]> = Driver.of([])
    
    let dataSource = RxTableViewSectionedReloadDataSource<TableViewSectionModel>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: item.reusableIdentifier, for: indexPath)
        if let cell = cell as? ViewModelAssignable {
            cell.assignViewModel(viewModel: item.viewModel)
        }
        return cell
    })
    
}

struct TableViewSectionModel {
    var items: [Item]
}

extension TableViewSectionModel: SectionModelType {
    typealias Item = TableViewSectionItem
    
    init(original: TableViewSectionModel,
         items: [TableViewSectionItem]) {
        self = original
        self.items = items
    }
}

struct TableViewSectionItem {
    var reusableIdentifier: String
    var viewModel: BaseTableViewCellViewModel
    
    init(reusableIdentifier: String, viewModel: BaseTableViewCellViewModel) {
        self.reusableIdentifier = reusableIdentifier
        self.viewModel = viewModel
    }
}

extension BaseTableViewControllerViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.viewModel.cellHeight
    }
    
}


struct AnimatableTableViewSectionModel {
    var sectionID: Int
    var items: [Item]
}

extension AnimatableTableViewSectionModel: AnimatableSectionModelType {
    var identity: Int { return sectionID }
    
    typealias Item = AnimatableTableViewSectionItem
    
    init(original: AnimatableTableViewSectionModel,
         items: [AnimatableTableViewSectionItem]) {
        self = original
        self.items = items
    }
}

struct AnimatableTableViewSectionItem: IdentifiableType, Equatable {
    var reusableIdentifier: String
    var viewModel: BaseTableViewCellViewModel
    var id: Int
    
    var identity: Int {
        return id
    }
    
    init(reusableIdentifier: String, viewModel: BaseTableViewCellViewModel, id: Int) {
        self.reusableIdentifier = reusableIdentifier
        self.viewModel = viewModel
        self.id = id
    }
}

func ==(lhs: AnimatableTableViewSectionItem, rhs: AnimatableTableViewSectionItem) -> Bool {
    return lhs.id == rhs.id
}

