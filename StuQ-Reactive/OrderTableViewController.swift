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
    
    private var price = Variable(118)
    private var count = Variable(1)
    private var couponPrice = Variable(1)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        minusButton.rx_tap
            .subscribeNext {
                self.count.value -= 1
            }
            .addDisposableTo(disposeBag)
        
        plusButton.rx_tap
            .subscribeNext {
                self.count.value += 1
            }
            .addDisposableTo(disposeBag)
        
        countTextField.rx_text
            .subscribeNext { (text) in
                guard let i = Int(text) else {return}
                self.count.value = i
            }
            .addDisposableTo(disposeBag)
        
        count.asObservable()
            .subscribeNext { (count) in
                self.countTextField.text = "\(count)"
            }
            .addDisposableTo(disposeBag)
        
        Observable
            .combineLatest(price.asObservable(), count.asObservable(), resultSelector: *)
            .subscribeNext { (subTotal) in
                self.subtotalLabel.text = "\(subTotal)"
            }
            .addDisposableTo(disposeBag)
        
        Observable
            .combineLatest(price.asObservable(), count.asObservable(), couponPrice.asObservable()) { (price, count, coupon) -> Int in
                return price * count - coupon
            }
            .subscribeNext { (total) in
                self.totalLabel.text = "\(total)"
            }
            .addDisposableTo(disposeBag)
    }
}

