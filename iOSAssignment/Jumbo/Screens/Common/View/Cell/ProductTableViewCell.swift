//
//  ProductTableViewCell.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit
import RxSwift

final class ProductTableViewCell: BaseTableViewCell<ProductTableViewCellViewModel> {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var stepper: StepperView!
    
    // Use it instead of tableViewDelegate:didSelectRowAtIndex
    @IBAction func cellButtonDidTap(_ sender: AnyObject) {
        
    }
    
    override func bind() {
        viewModel.productImage
            .skip(1)
            .subscribe(onNext: { [weak self] image  in
                self?.productImage.image = image
            }).disposed(by: disposeBag)
        
        name.text = viewModel.name
        quantity.text = viewModel.quantity
        price.text = viewModel.price
        unitPrice.text = viewModel.unitPrice
        
        stepper.setMaxCount(maxCount: viewModel.stepperMaxCount)
        stepper.setMinCount(minCount: viewModel.stepperMinCount)
        stepper.setCount(count: viewModel.quantityInCart)
        
        let addToCartSignal = PublishSubject<Void>()
        let deleteFromCartSignal = PublishSubject<Void>()
        stepper.configureTapEvents(incrementButtonTappedSignal: addToCartSignal, decrementButtonTappedSignal: deleteFromCartSignal)
        
        addToCartSignal.asObservable()
            .bind(onNext: { [weak self] in
                self?.viewModel.productCellAction(action: .addToCart)
            }).disposed(by: disposeBag)
        
        deleteFromCartSignal.asObservable()
            .bind(onNext: { [weak self] in
                self?.viewModel.productCellAction(action: .deleteFromCart)
            }).disposed(by: disposeBag)
    }
    
}
