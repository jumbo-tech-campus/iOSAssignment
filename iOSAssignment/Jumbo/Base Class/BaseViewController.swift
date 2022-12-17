//
//  BaseViewController.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import UIKit
import RxSwift

class BaseViewController<T: ViewModel>: UIViewController {

    var viewModel: T!
    
    var disposeBag = DisposeBag()
    
    var setAsActive: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
    }
    
    func bind() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if setAsActive {
            viewModel.setAsActive()
        }
    }
    
    convenience init(
        viewModel: T
      , loadXib: Bool = true
    ) {
        if loadXib {
            let nibName = String(describing: type(of: self))
            self.init(nibName: nibName, bundle: nil) // Have to use XIBs
        } else {
            self.init(nibName: nil, bundle: nil)
        }
       
        self.viewModel = viewModel
    }
}
