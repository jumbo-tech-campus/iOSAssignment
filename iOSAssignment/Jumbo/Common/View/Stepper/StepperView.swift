//
//  StepperView.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//
//

import UIKit
import RxSwift

let MINCOUNT = 0
let MAXCOUNT = 10

public class StepperView: UIView {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var currentCount: Int = MINCOUNT
    var maxCount: Int =  MINCOUNT
    var minCount: Int = MAXCOUNT
    
    private var incrementButtonTappedSignal: PublishSubject<Void>?
    private var decrementButtonTappedSignal: PublishSubject<Void>?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    
    fileprivate func load() {
        let view = Bundle(for: StepperView.self).loadNibNamed(String(describing: StepperView.self), owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
    }
    
    private func configureUI() {
        self.addButton.layer.cornerRadius = 5
        self.addButton.layer.masksToBounds = true
        self.addButton.tintColor = .white
        self.addButton.setTitle("Add", for: .normal)
    }
    
    private func checkButtonState() {
        if self.currentCount > self.minCount {
            self.decrementButton.isEnabled = true
            self.decrementButton.alpha = 1.0
        } else {
            self.decrementButton.isEnabled = false
            self.decrementButton.alpha = 0.5
        }
        
        if (self.currentCount < self.maxCount) {
            self.incrementButton.isEnabled = true
            self.incrementButton.alpha = 1.0
        } else {
            self.incrementButton.isEnabled = false
            self.incrementButton.alpha = 0.5
        }
        updateCountLabel()
        setupAddButton()
    }
    
    private func updateCountLabel() {
        self.countLabel.text = "\(currentCount)"
    }
    
    private func setupAddButton() {
        self.addButton.isHidden = true
        self.addButton.isHidden = !(self.currentCount == 0)
        self.decrementButton.isHidden = (self.currentCount == 0)
        self.incrementButton.isHidden = (self.currentCount == 0)
        self.countLabel.isHidden = (self.currentCount == 0)
    }
    
    func setMinCount(minCount: Int) {
        self.minCount = minCount
        if self.currentCount < self.minCount {
            self.currentCount = self.minCount
        }
        self.checkButtonState()
    }

    func setMaxCount(maxCount: Int) {
        self.maxCount = maxCount
        if self.currentCount > self.maxCount {
            self.currentCount = self.maxCount
        }
        self.checkButtonState()
    }
    
    func setCount(count: Int) {
        if count >= self.minCount && count <= self.maxCount {
            self.currentCount = count
        }
        self.checkButtonState()
    }
    
    func configureTapEvents(incrementButtonTappedSignal: PublishSubject<Void>?
                            , decrementButtonTappedSignal: PublishSubject<Void>?) {
        self.incrementButtonTappedSignal = incrementButtonTappedSignal
        self.decrementButtonTappedSignal = decrementButtonTappedSignal
    }
    
    @IBAction func decrementButtonTapped(_ sender: Any) {
        if self.currentCount > self.minCount {
            self.currentCount -= 1
        }
        self.countLabel.text = "\(self.currentCount)"
        self.checkButtonState()
        self.decrementButtonTappedSignal?.onNext(())
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        if self.currentCount < self.maxCount {
            self.currentCount += 1;
        }
        self.countLabel.text = "\(self.currentCount)"
        self.checkButtonState()
        self.incrementButtonTappedSignal?.onNext(())
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.incrementButtonTapped(sender)
        self.updateCountLabel()
    }
}
