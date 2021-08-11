//
//  ReturnOrderViewController.swift
//  OSA
//
//  Created by Happy Sanz Tech on 24/03/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import UIKit
import SDWebImage

protocol ReturnReasonListDisplayLogic: class
{
    func successFetchedItems(viewModel: ReturnReasonListModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: ReturnReasonListModel.Fetch.ViewModel)
}
protocol ReturnOrderRequestDisplayLogic: class
{
    func successFetchedItems(viewModel: ReturnOrderRequestModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: ReturnOrderRequestModel.Fetch.ViewModel)
}

class ReturnOrderViewController: UIViewController, ReturnReasonListDisplayLogic, ReturnOrderRequestDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var displayedReturnReasonListData: [ReturnReasonListModel.Fetch.ViewModel.DisplayedReturnReasonListData] = []
    var selectedIndex = IndexPath(row: -1, section: 0)

    var interactor: ReturnReasonListBusinessLogic?
    var interactor1: ReturnOrderRequestBusinessLogic?
    var id = String()
    var idArr = [String]()
    var order_id = String()
    var productName = String()
    var productImg = String()
    var productPrice = String()
    var selectedReplceIndex = NSIndexPath()
    var questionId = [String]()
    var selectedQuestionId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchItems(request: ReturnReasonListModel.Fetch.Request(user_id:GlobalVariables.shared.customer_id))
        
        self.productImage.sd_setImage(with: URL(string: productImg), placeholderImage: UIImage(named: ""))
        self.productTitleLbl.text = productName
        self.priceLbl.text = "₹ \(productPrice)"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        let viewController = self
        let interactor = ReturnReasonListInteractor()
        let presenter = ReturnReasonListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let viewController1 = self
        let interactor1 = ReturnOrderRequestInteractor()
        let presenter1 = ReturnOrderRequestPresenter()
        viewController1.interactor1 = interactor1
        interactor1.presenter1 = presenter1
        presenter1.viewController1 = viewController1
       
    }
    
    @IBAction func submitAction(_ sender: Any) {
       
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Submitted Successfully", complition: {
            
          })
        
    }
    
//
    func successFetchedItems(viewModel: ReturnReasonListModel.Fetch.ViewModel) {
        
        displayedReturnReasonListData = viewModel.displayedReturnReasonListData
        self.idArr.removeAll()
        
        for data in displayedReturnReasonListData {
            let Id = data.id
            self.idArr.append(Id!)
        }
        self.tableView.reloadData()
    }
    
    func errorFetchingItems(viewModel: ReturnReasonListModel.Fetch.ViewModel) {
        
    }
    
//
    func successFetchedItems(viewModel: ReturnOrderRequestModel.Fetch.ViewModel) {
        
    }
    
    func errorFetchingItems(viewModel: ReturnOrderRequestModel.Fetch.ViewModel) {
        
    }
}

extension ReturnOrderViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedReturnReasonListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReturnReasonListTableViewCell
        
        let data = displayedReturnReasonListData[indexPath.row]
//        cell.status.text = data.order_id
        cell.reasonText.text = data.question
//        if selectedIndex == indexPath { cell.backgroundColor = UIColor.white }
        cell.selectionStyle = .none
//        cell.selectionStyle = .none
//        cell.selectButton.tag = indexPath.row
//        cell.selectButton.addTarget(self, action: #selector(returnOrderButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let selected_id = idArr[indexPath.row]
        self.id = selected_id
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    @objc func returnOrderButtonClicked(sender: UIButton){
        
         let buttonClicked = sender.tag
         print(buttonClicked)
         let selectedIndex = Int(buttonClicked)
         print(selectedIndex)
            
    }
}
