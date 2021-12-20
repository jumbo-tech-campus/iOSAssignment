//
//  AddCartButton.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

protocol AddCartDelegate: AnyObject {
    func didStartInteraction(indexPath: IndexPath)
    func didAddToCart(indexPath: IndexPath)
    func didRemoveFromCart(indexPath: IndexPath)
}

class AddCartButton: UIView {
    
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private let containerView: UIView
    private let amountOrAddLabel: UILabel
    let addButton: UIButton
    let removeButton: UIButton
    private let amountLabel: UILabel
    private let stackView: UIStackView
    
    var indexPathToReport: IndexPath?
    
    weak var delegate: AddCartDelegate?
    
    override init(frame: CGRect) {
        
        containerView = UIView()
        amountOrAddLabel = UILabel()
        addButton = UIButton(type: .custom)
        removeButton = UIButton(type: .custom)
        amountLabel = UILabel()
        stackView = UIStackView()
        
        tapGestureRecognizer = nil
        
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForReuse() {
        indexPathToReport = nil
    }
    
    func setupComponents() {
        
        containerView.backgroundColor = .jumboGreen
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.jumboGreen.cgColor
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        amountOrAddLabel.textColor = .white
        amountOrAddLabel.text = "+"
        amountOrAddLabel.font = .jumboText(withSize: 24)
        amountOrAddLabel.textAlignment = .center
        amountOrAddLabel.isUserInteractionEnabled = true
        
        addViewsForInitialState()
        
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(removeButton)
        
        addButton.setTitle("+", for: .normal)
        removeButton.setTitle("-", for: .normal)
        amountLabel.text = "0"
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnAmountOrAddLabel))
        amountOrAddLabel.addGestureRecognizer(tapGestureRecognizer!)
        
        addButton.addTarget(self, action: #selector(didTapOnAddToCart), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(didTapOnRemoveFromCart), for: .touchUpInside)
        
        [addButton.titleLabel, amountLabel, removeButton.titleLabel].forEach { $0?.font = .jumboTextBold(withSize: 16) }
    }
    
    @objc func didTapOnAmountOrAddLabel() {
        guard let indexPath = indexPathToReport else { return }
        delegate?.didStartInteraction(indexPath: indexPath)
    }
    
    @objc func didTapOnAddToCart() {
        guard let indexPath = indexPathToReport else { return }
        delegate?.didAddToCart(indexPath: indexPath)
    }
    
    @objc func didTapOnRemoveFromCart() {
        guard let indexPath = indexPathToReport else { return }
        delegate?.didRemoveFromCart(indexPath: indexPath)
    }
    
    func setAmount(_ amount: Int) {
        if amount > 0 {
            amountOrAddLabel.backgroundColor = .white
            amountOrAddLabel.textColor = .black
        } else {
            amountOrAddLabel.backgroundColor = .jumboGreen
            amountOrAddLabel.textColor = .white
        }
        amountLabel.text = "\(amount)"
        amountOrAddLabel.text = amount > 0 ? "\(amount)" : "+"
        
    }
    
    func updateState(_ state: ProductCellState, animated: Bool) {
        switch state {
        case .interaction:
            amountOrAddLabel.removeFromSuperview()
            addViewsForInteractionState()
            setupConstraintsForInteractionState()
            if animated {
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.containerView.layoutIfNeeded()
                }
            } else {
                containerView.layoutIfNeeded()
            }
        case .normal:
            stackView.removeFromSuperview()
            addViewsForInitialState()
            setupConstraintsForInitialState()
            if animated {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.containerView.layoutIfNeeded()
            }
            } else {
                containerView.layoutIfNeeded()
            }
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 24),
            removeButton.widthAnchor.constraint(equalToConstant: 24),
            amountLabel.widthAnchor.constraint(equalToConstant: 72),
        ])
        
        setupConstraintsForInitialState()
    }
    
    func addViewsForInteractionState() {
        containerView.addSubviewForAutolayout(stackView)
    }
    
    func addViewsForInitialState() {
        containerView.addSubviewForAutolayout(amountOrAddLabel)
        addSubviewForAutolayout(containerView)
    }
    
    func setupConstraintsForInitialState() {
        NSLayoutConstraint.activate([
            amountOrAddLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            amountOrAddLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            amountOrAddLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            amountOrAddLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func setupConstraintsForInteractionState() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
