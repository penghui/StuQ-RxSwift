//
//  OrderTableViewController.swift
//  StuQ-Reactive
//
//  Created by DianQK on 8/30/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OrderTableViewController: UITableViewController {

    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var countTextField: UITextField!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var subtotalLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    
    private var price = 118
    private var count = 1 {
        didSet {
            countTextField.text = "\(count)"
        }
    }
    
    private var couponPrice = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        minusButton.addTarget(self, action: #selector(OrderTableViewController.minusClicked), forControlEvents: .TouchUpInside)
        plusButton.addTarget(self, action: #selector(OrderTableViewController.plusClicked), forControlEvents: .TouchUpInside)
        
        countTextField.addTarget(self, action: #selector(OrderTableViewController.textChanged), forControlEvents: .EditingChanged)
        
        calculatorSubTotalAndTotal()
    }
    
    func minusClicked() {
        count -= 1
        calculatorSubTotalAndTotal()
    }
    
    func plusClicked() {
        count += 1
        calculatorSubTotalAndTotal()
    }
    
    func textChanged() {
        guard let text = countTextField.text else {
            return
        }
        guard let i = Int(text) else {
            return
        }
        count = i;
        calculatorSubTotalAndTotal()
    }
    
    func calculatorSubTotalAndTotal() {
        subtotalLabel.text = "\(price * count)"
        totalLabel.text = "\(price * count - couponPrice)"
    }
}

