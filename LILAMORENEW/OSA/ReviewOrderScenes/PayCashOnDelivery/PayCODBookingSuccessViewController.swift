//
//  PayCODBookingSuccessViewController.swift
//  OSA
//
//  Created by Happy Sanz Tech on 23/03/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import UIKit

class PayCODBookingSuccessViewController: UIViewController {

    @IBOutlet weak var orderSuccessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderSuccessLabel.text = "Your order \(GlobalVariables.shared.order_id) was placedcessc with success"
    }
    
    
    @IBAction func to_orderHistryAction(_ sender: Any) {
        
    }
    
}
