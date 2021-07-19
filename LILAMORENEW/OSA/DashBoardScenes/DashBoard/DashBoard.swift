//
//  DashBoard.swift
//  OSA                                                                                            
//
//  Created by Happy Sanz Tech on 11/02/21.
//

import UIKit
import SideMenu
import SDWebImage
import MBProgressHUD
 
protocol DashBoardDisplayLogic: class
{
    func successFetchedItems(viewModel: DashBoardModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: DashBoardModel.Fetch.ViewModel)
}
protocol CategoryDisplayLogic: class
{
    func successFetchedItems(viewModel: CategoryModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: CategoryModel.Fetch.ViewModel)
}
protocol BestSellingDisplayLogic: class
{
    func successFetchedItems(viewModel: BestSellingModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: BestSellingModel.Fetch.ViewModel)
}
protocol NewArrivalsDisplayLogic: class
{
    func successFetchedItems(viewModel: NewArrivalsModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: NewArrivalsModel.Fetch.ViewModel)
}
protocol AdvertisementDisplayLogic: class
{
    func successFetchedItems(viewModel: AdvertisementModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: AdvertisementModel.Fetch.ViewModel)
}
protocol WishListAddDisplayLogic: class
{
    func successFetchedItems(viewModel: WishListAddModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: WishListAddModel.Fetch.ViewModel)
}
protocol WishListDeleteDisplayLogic: class
{
    func successFetchedItems(viewModel: WishListDeleteModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: WishListDeleteModel.Fetch.ViewModel)
}

class DashBoard: UIViewController, DashBoardDisplayLogic,CategoryDisplayLogic,BestSellingDisplayLogic,NewArrivalsDisplayLogic,AdvertisementDisplayLogic, WishListAddDisplayLogic, WishListDeleteDisplayLogic,UIPopoverPresentationControllerDelegate{
 
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var advertisementTableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextfield: UITextField!
//    @IBOutlet weak var leftbutton: UIBarButtonItem!
    
    var index = 0
    var inForwardDirection = true
    var timer: Timer?
    var interactor: DashBoardBusinessLogic?
    var interactor1: CategoryBusinessLogic?
    var interactor2: BestSellingBusinessLogic?
    var interactor3: NewArrivalsBusinessLogic?
    var interactor4: AdvertisementBusinessLogic?
    var interactor5: WishListAddBusinessLogic?
    var interactor6: WishListDeleteBusinessLogic?
    
    var router: (NSObjectProtocol & DashBoardRoutingLogic & DashBoardDataPassing)?
    var displayedDashBoardData: [DashBoardModel.Fetch.ViewModel.DisplayedDashBoardData] = []
    var displayedCategoryData: [CategoryModel.Fetch.ViewModel.DisplayedCategoryData] = []
    var displayedBestSellingData: [BestSellingModel.Fetch.ViewModel.DisplayedBestSellingData] = []
    var displayedNewArrivalsData: [NewArrivalsModel.Fetch.ViewModel.DisplayedNewArrivalsData] = []
    var displayedAdvertisementData: [AdvertisementModel.Fetch.ViewModel.DisplayedAdvertisementData] = []
     
    var bestSellingProductIdArr  = [String]()
    var NewArrivalIdArr  = [String]()
    var selectedProductIdArr = String()
    var selectedNewArrivalIdArr = String()
    var indexArray  : [NSIndexPath]?
    var fromSearchText = String()
    var dashBoarddata_toDetail = String()
    let transparentView = UIView()
    let TableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    var product_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.hideKeyboardWhenTappedAround()
        self.sideMenuButton()
        self.fromSearchText = "to_searchList"
//        leftbutton.image = UIImage(named:"recent-2")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
//        self.navigationController?.navigationBar.barTintColor = UIColor.blue
//        self.navigationController?.navigationBar.tintColor = UIColor.black
//        if let navigationbar = self.navigationController?.navigationBar {
            
//            navigationbar.setGradientBackground(colors: [UIColor(red: 189.0/255.0, green: 6.0/255.0, blue: 33.0/255.0, alpha: 1.0), UIColor(red: 95.0/255.0, green: 3.0/255.0, blue: 17.0/255.0, alpha: 1.0)], startPoint: .left, endPoint: .right)
//            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
//            navigationController?.navigationBar.titleTextAttributes = textAttributes
//        }
        interactor?.fetchItems(request: DashBoardModel.Fetch.Request(user_id:"1"))
        interactor1?.fetchItems(request: CategoryModel.Fetch.Request(user_id:"1"))
        interactor2?.fetchItems(request: BestSellingModel.Fetch.Request(user_id:"1"))
        interactor3?.fetchItems(request: NewArrivalsModel.Fetch.Request(user_id:"1"))
        interactor4?.fetchItems(request: AdvertisementModel.Fetch.Request(user_id:"1"))
       
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let user_Id = UserDefaults.standard.object(forKey: UserDefaultsKey.customer_idkey.rawValue) ?? ""
        
        if user_Id as! String == ""
        {
            
        }
        else
        {
            GlobalVariables.shared.customer_id = UserDefaults.standard.object(forKey: UserDefaultsKey.customer_idkey.rawValue) as! String
        }
        searchTextfield.setCorner(radius: 25)
        if let myImage = UIImage(named: "search"){
            searchTextfield.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
            searchTextfield.setCorner(radius: 25)
        }
    }
    
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
//    override func viewDidLayoutSubviews() {
//
    
//        searchBarView.layerGradient(startPoint: .left, endPoint: .right, colorArray: [UIColor(red: 189.0/255.0, green: 6.0/255.0, blue: 33.0/255.0, alpha: 1.0).cgColor, UIColor(red: 95.0/255.0, green: 3.0/255.0, blue: 17.0/255.0, alpha: 1.0).cgColor], type: .axial)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.alpha = 1
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
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
        let interactor = DashBoardInteractor()
        let presenter = DashBoardPresenter()
        let router = DashBoardRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        let viewController1 = self
        let interactor1 = CategoryInteractor()
        let presenter1 = CategoryPresenter()
        viewController1.interactor1 = interactor1
        interactor1.presenter1 = presenter1
        presenter1.viewController1 = viewController1
        
        let viewController2 = self
        let interactor2 = BestSellingInteractor()
        let presenter2 = BestSellingPresenter()
        viewController2.interactor2 = interactor2
        interactor2.presenter2 = presenter2
        presenter2.viewController2 = viewController2
        
        let viewController3 = self
        let interactor3 = NewArrivalsInteractor()
        let presenter3 = NewArrivalsPresenter()
        viewController3.interactor3 = interactor3
        interactor3.presenter3 = presenter3
        presenter3.viewController3 = viewController3
        
        let viewController4 = self
        let interactor4 = AdvertisementInteractor()
        let presenter4 = AdvertisementPresenter()
        viewController4.interactor4 = interactor4
        interactor4.presenter4 = presenter4
        presenter4.viewController4 = viewController4
      
        let viewController5 = self
        let interactor5 = WishListAddInteractor()
        let presenter5 = WishListAddPresenter()
        viewController5.interactor5 = interactor5
        interactor5.presenter5 = presenter5
        presenter5.viewController5 = viewController5
        
        let viewController6 = self
        let interactor6 = WishListDeleteInteractor()
        let presenter6 = WishListDeletePresenter()
        viewController6.interactor6 = interactor6
        interactor6.presenter6 = presenter6
        presenter6.viewController6 = viewController6
    }
    
    @IBAction func NewArrivalDetailAction(_ sender: Any) {
        self.dashBoarddata_toDetail = "to_newArrival"
        self.performSegue(withIdentifier: "newArrivallSegue", sender: self)
    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
//        SideMenuManager.default.menuAnimationFadeStrength = 0.5
    }
    
    func makeSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.allowPushOfSameClassTwice = false
        settings.presentationStyle = .viewSlideOut
        settings.presentationStyle.backgroundColor = .black
        settings.presentationStyle.presentingEndAlpha = 0.5
        settings.statusBarEndAlpha = 0.5
        return settings
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == searchTextfield
        {
            if searchTextfield.text?.isEmpty == true{
               AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Empty", complition: {
               })
            }
            else{
//
                self.performSegue(withIdentifier: "to_searchList", sender: self)
            }
        }
            return true
    }
    
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool  {
////        self.popOver(sender:searchTextfield)
////        dataSource = ["Apple", "Mango", "Orange"]
//////          selectedButton = UITextField
////          addTransparentView(frames: searchTextfield.frame)
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//             selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
//             removeTransparentView()
//         }
    
    func addTransparentView(frames: CGRect) {
             let window = UIApplication.shared.keyWindow
             transparentView.frame = window?.frame ?? self.view.frame
             self.view.addSubview(transparentView)
             
             TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
             self.view.addSubview(TableView)
             TableView.layer.cornerRadius = 5
             
             transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
             TableView.reloadData()
             let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
             transparentView.addGestureRecognizer(tapgesture)
             transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                 self.transparentView.alpha = 0.5
                 self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
             }, completion: nil)
         }
    
     @objc func removeTransparentView() {
             let frames = selectedButton.frame
             UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                 self.transparentView.alpha = 0
                 self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
             }, completion: nil)
         }

//    Banner Display Logic
    func successFetchedItems(viewModel: DashBoardModel.Fetch.ViewModel) {
        MBProgressHUD.hide(for: self.view, animated: true)
        displayedDashBoardData = viewModel.displayedDashBoardData
          print("123456")
        print(displayedDashBoardData.count)
        if displayedDashBoardData.count > 1 {
            self.startTimer()
        }
        self.bannerCollectionView.reloadData()
    }
    
    func errorFetchingItems(viewModel: DashBoardModel.Fetch.ViewModel) {
        
    }
    
//    Category DispayLogic
    func successFetchedItems(viewModel: CategoryModel.Fetch.ViewModel) {
        displayedCategoryData = viewModel.displayedCategoryData
          print("123456")
        print(displayedCategoryData.count)
        self.categoryCollectionView.reloadData()
    }
    
    func errorFetchingItems(viewModel: CategoryModel.Fetch.ViewModel) {
        
    }
    
//    Best Selling DisplayLogic
    func successFetchedItems(viewModel: BestSellingModel.Fetch.ViewModel) {
        displayedBestSellingData = viewModel.displayedBestSellingData  
          print("123456")
        self.bestSellingProductIdArr.removeAll()
        for data in displayedBestSellingData {
            let product_id = data.id
            self.bestSellingProductIdArr.append(product_id!)
            
        }
        print(displayedBestSellingData.count)
        self.bestSellingCollectionView.reloadData()
    }

    func errorFetchingItems(viewModel: BestSellingModel.Fetch.ViewModel) {
        
    }
//    New Arrivals DisplayLogic
    func successFetchedItems(viewModel: NewArrivalsModel.Fetch.ViewModel) {
        displayedNewArrivalsData = viewModel.displayedNewArrivalsData
        for data in displayedNewArrivalsData {
            let id = data.id
            self.NewArrivalIdArr.append(id!)
        }
        self.tableView.reloadData()
    }
    
    func errorFetchingItems(viewModel: NewArrivalsModel.Fetch.ViewModel) {
        
    }
    
//    Advertisement DisplayLogic
    func successFetchedItems(viewModel: AdvertisementModel.Fetch.ViewModel) {
        displayedAdvertisementData = viewModel.displayedAdvertisementData
        self.advertisementTableView.reloadData()
        
    }
    
    func errorFetchingItems(viewModel: AdvertisementModel.Fetch.ViewModel) {
        
    }
    
//    Add to WishList DisplayLogic
    func successFetchedItems(viewModel: WishListAddModel.Fetch.ViewModel) {
        
        interactor2?.fetchItems(request: BestSellingModel.Fetch.Request(user_id:"1"))
        interactor3?.fetchItems(request: NewArrivalsModel.Fetch.Request(user_id:"1"))
    }
    
    func errorFetchingItems(viewModel: WishListAddModel.Fetch.ViewModel) {
        
    }
    
//    WishListDelete DisplayLogic
    func successFetchedItems(viewModel: WishListDeleteModel.Fetch.ViewModel) {
        
        interactor2?.fetchItems(request: BestSellingModel.Fetch.Request(user_id:"1"))
        interactor3?.fetchItems(request: NewArrivalsModel.Fetch.Request(user_id:"1"))
    }
    
    func errorFetchingItems(viewModel: WishListDeleteModel.Fetch.ViewModel) {
        
    }
    
     @objc public override func sideMenuButtonClick(){
        
        self.performSegue(withIdentifier: "to_sideMenu", sender: self)
    }
}

extension DashBoard : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView
        {
           return displayedNewArrivalsData.count
        }
        else
        {
           return displayedAdvertisementData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewArrivalsTableViewCell
        let newArrivaldata = displayedNewArrivalsData[indexPath.row]
        cell.newArrivalImage.sd_setImage(with: URL(string: newArrivaldata.product_cover_img!), placeholderImage: UIImage(named: ""))
        cell.productTitlelabel.text = newArrivaldata.product_name
        cell.MrpPriceLabel.text = "₹\(newArrivaldata.prod_actual_price!)"
        cell.actualPriceLabel.text = "₹\(newArrivaldata.prod_mrp_price!)"
            
            if newArrivaldata.review_average == "1" {
                
                cell.image1.image = UIImage(named:"star (3)")
                cell.image2.image = UIImage(named:"star (3)-1")
                cell.image3.image = UIImage(named:"star (3)-1")
                cell.image4.image = UIImage(named:"star (3)-1")
                cell.image5.image = UIImage(named:"star (3)-1")
            }
            else if newArrivaldata.review_average == "2" {
                
                cell.image1.image = UIImage(named:"star (3)")
                cell.image2.image = UIImage(named:"star (3)")
                cell.image3.image = UIImage(named:"star (3)-1")
                cell.image4.image = UIImage(named:"star (3)-1")
                cell.image5.image = UIImage(named:"star (3)-1")
            }
            else if newArrivaldata.review_average == "3" {
                
                cell.image1.image = UIImage(named:"star (3)")
                cell.image2.image = UIImage(named:"star (3)")
                cell.image3.image = UIImage(named:"star (3)")
                cell.image4.image = UIImage(named:"star (3)-1")
                cell.image5.image = UIImage(named:"star (3)-1")
            }
            else if newArrivaldata.review_average == "4" {
                
                cell.image1.image = UIImage(named:"star (3)")
                cell.image2.image = UIImage(named:"star (3)")
                cell.image3.image = UIImage(named:"star (3)")
                cell.image4.image = UIImage(named:"star (3)")
                cell.image5.image = UIImage(named:"star (3)-1")
            }
            else if newArrivaldata.review_average == "5" {
                
                cell.image1.image = UIImage(named:"star (3)")
                cell.image2.image = UIImage(named:"star (3)")
                cell.image3.image = UIImage(named:"star (3)")
                cell.image4.image = UIImage(named:"star (3)")
                cell.image5.image = UIImage(named:"star (3)")
            }
            
            if newArrivaldata.wishlisted == "1"
            {
            cell.likeImage.image = UIImage(named:"heart (1)-1")
            }
            else if newArrivaldata.wishlisted == "0"
            {
            cell.likeImage.image = UIImage(named:"heart (1)")
            }
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(NewArrivalsAddButtonClicked(sender:)), for: .touchUpInside)
           return cell
        }
         else
         {
         let cell = advertisementTableView.dequeueReusableCell(withIdentifier: "adsCell", for: indexPath) as! AdsTableViewCell
         let adsData = displayedAdvertisementData[indexPath.row]
         cell.adsImageView.sd_setImage(with: URL(string: adsData.ad_img!), placeholderImage: UIImage(named: ""))
           return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectItemAt indexPath: IndexPath) {
       
        if tableView == tableView {
            let data = displayedAdvertisementData[indexPath.row]
            self.product_id = data.id!
            self.performSegue(withIdentifier: "newArrival_product", sender: self)
        }
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
        }
    }
    
    @objc func scrollToNextCell()
    {
        //scroll to next cell
        let items = bannerCollectionView.numberOfItems(inSection: 0)
        if (items - 1) == index {
            bannerCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        } else if index == 0 {
            bannerCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            bannerCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if inForwardDirection {
            if index == (items - 1) {
                index -= 1
                inForwardDirection = false
            } else {
                index += 1
            }
        } else {
            if index == 0 {
                index += 1
                inForwardDirection = true
            } else {
                index -= 1
            }
        }
    }
}


extension DashBoard : UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate {
        
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if collectionView == self.bannerCollectionView
       {
           return displayedDashBoardData.count
       }
       else if collectionView == self.categoryCollectionView
       {
           return displayedCategoryData.count
       }
       else
       {
           return displayedBestSellingData.count
       }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       if collectionView == self.bannerCollectionView
       {
       let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DashBoardBannerCell
       let bannerImg = displayedDashBoardData[indexPath.row]
       
       cell.bannerImg.sd_setImage(with: URL(string: bannerImg.banner_image!), placeholderImage: UIImage(named: ""))
//           cell.bannerTitle.text = bannerImg.banner_title
//           cell.offerlabel.text = bannerImg.banner_desc
//          cell.bannerDescLabel.text = bannerImg.category_name
       return cell
       }

       else if collectionView == self.categoryCollectionView
       {
           let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
           let categoryData = displayedCategoryData[indexPath.row]
           
           cell.CategoryImg.sd_setImage(with: URL(string: categoryData.category_image!), placeholderImage: UIImage(named: ""))
           cell.catLabel.text = categoryData.category_name
           return cell
       }
       
       else
       {
           let cell = bestSellingCollectionView.dequeueReusableCell(withReuseIdentifier: "bestSellingCell", for: indexPath) as! BestSellingCollectionViewCell
           let bestSellingData = displayedBestSellingData[indexPath.row]
           let percentageText = "% off"
           cell.sellingImage.sd_setImage(with: URL(string: bestSellingData.product_cover_img!), placeholderImage: UIImage(named: ""))
           cell.productTitleLabel.text = bestSellingData.product_name
           cell.actualPricelabel.text = "₹\(bestSellingData.prod_actual_price!)"
           cell.discoutPricelabel.text = "₹\(bestSellingData.prod_mrp_price!)"
           cell.offerPercentageLabel.text = bestSellingData.offer_percentage!+percentageText
        
        if bestSellingData.review_average == "1" {
            
            cell.image1.image = UIImage(named:"star (3)")
            cell.image2.image = UIImage(named:"star (3)-1")
            cell.image3.image = UIImage(named:"star (3)-1")
            cell.image4.image = UIImage(named:"star (3)-1")
            cell.image5.image = UIImage(named:"star (3)-1")
        }
        else if bestSellingData.review_average == "2" {
            
            cell.image1.image = UIImage(named:"star (3)")
            cell.image2.image = UIImage(named:"star (3)")
            cell.image3.image = UIImage(named:"star (3)-1")
            cell.image4.image = UIImage(named:"star (3)-1")
            cell.image5.image = UIImage(named:"star (3)-1")
        }
        else if bestSellingData.review_average == "3" {
            
            cell.image1.image = UIImage(named:"star (3)")
            cell.image2.image = UIImage(named:"star (3)")
            cell.image3.image = UIImage(named:"star (3)")
            cell.image4.image = UIImage(named:"star (3)-1")
            cell.image5.image = UIImage(named:"star (3)-1")
        }
        else if bestSellingData.review_average == "4" {
            
            cell.image1.image = UIImage(named:"star (3)")
            cell.image2.image = UIImage(named:"star (3)")
            cell.image3.image = UIImage(named:"star (3)")
            cell.image4.image = UIImage(named:"star (3)")
            cell.image5.image = UIImage(named:"star (3)-1")
        }
        else if bestSellingData.review_average == "5"{
            
            cell.image1.image = UIImage(named:"star (3)")
            cell.image2.image = UIImage(named:"star (3)")
            cell.image3.image = UIImage(named:"star (3)")
            cell.image4.image = UIImage(named:"star (3)")
            cell.image5.image = UIImage(named:"star (3)")
        }
        
           if bestSellingData.wishlisted == "1"
           {
            cell.likeImage.image = UIImage(named:"heart (1)-1")
           }
           else if bestSellingData.wishlisted == "0"
           {
            cell.likeImage.image = UIImage(named:"heart (1)")
            
           }
    
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(BestSellingAddButtonClicked(sender:)), for: .touchUpInside)

           return cell
       }
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == bestSellingCollectionView {
            let data = displayedBestSellingData[indexPath.row]
            self.product_id = data.id!
            self.performSegue(withIdentifier: "dashboard_product", sender: self)
        }
    }
    
    @objc func BestSellingAddButtonClicked(sender: UIButton){
         
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
         let cell = bestSellingCollectionView.cellForItem(at: myIndexPath as IndexPath) as! BestSellingCollectionViewCell
//        let bestSellingData = displayedBestSellingData[indexPath.row]
            
                if cell.likeImage.image == UIImage(named:"heart (1)") {
            
                let buttonClicked = sender.tag
                print(buttonClicked)
                let selectedIndex = Int(buttonClicked)
                let sel = self.bestSellingProductIdArr[selectedIndex]
                self.selectedProductIdArr = String(sel)
                self.interactor5?.fetchItems(request: WishListAddModel.Fetch.Request(product_id:self.selectedProductIdArr , user_id: "1"))
             }
                else
                {
                    let buttonClicked = sender.tag
                    print(buttonClicked)
                    let selectedIndex = Int(buttonClicked)
                    let sel = self.bestSellingProductIdArr[selectedIndex]
                    self.selectedProductIdArr = String(sel)
                    self.interactor6?.fetchItems(request: WishListDeleteModel.Fetch.Request(product_id:self.selectedProductIdArr , user_id: "1"))
            }
    }
    
    @objc func NewArrivalsAddButtonClicked(sender: UIButton){
         
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
         let cell = tableView.cellForRow(at: myIndexPath as IndexPath) as! NewArrivalsTableViewCell
//        let bestSellingData = displayedBestSellingData[indexPath.row]
            
                if cell.likeImage.image == UIImage(named:"heart (1)") {
            
                let buttonClicked = sender.tag
                print(buttonClicked)
                let selectedIndex = Int(buttonClicked)
                let sel = self.NewArrivalIdArr[selectedIndex]
                self.selectedNewArrivalIdArr = String(sel)
                self.interactor5?.fetchItems(request: WishListAddModel.Fetch.Request(product_id:self.selectedNewArrivalIdArr , user_id: "1"))
             }
                else
                {
                    let buttonClicked = sender.tag
                    print(buttonClicked)
                    let selectedIndex = Int(buttonClicked)
                    let sel = self.NewArrivalIdArr[selectedIndex]
                    self.selectedNewArrivalIdArr = String(sel)
                    self.interactor6?.fetchItems(request: WishListDeleteModel.Fetch.Request(product_id:self.selectedNewArrivalIdArr , user_id: "1"))
            }
      }
    
   func popOver(sender : UITextField) {
        
      let searchVC = storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
         searchVC.delegate = self
         searchVC.strSearchName = self.searchTextfield.text! as NSString

         searchVC.modalPresentationStyle = .popover
         if let popoverController = searchVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            }
            present(searchVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "to_searchList")
        {
            let vc = segue.destination as! SearchListViewController
            vc.searchText = self.searchTextfield.text!
            vc.fromSearchText = self.fromSearchText
        }
        else if (segue.identifier == "newArrivallSegue")
        {
            let vc = segue.destination as! NewArrivalViewController
            vc.fromDashboardData = self.dashBoarddata_toDetail
        }
        else if (segue.identifier == "dashboard_product")
        {
            let vc = segue.destination as! ProductDetailsViewController
            vc.product_id = self.product_id
        }
        else if (segue.identifier == "newArrival_product")
        {
            let vc = segue.destination as! ProductDetailsViewController
            vc.product_id = self.product_id
        }
    }
}

extension DashBoard :RecentSearchListDelegate {
    
    func saveText(searchName: String) {
         self.searchTextfield.text = searchName
     }
}

extension UIView {
    
     func setCorner(radius: CGFloat) {
         layer.cornerRadius = radius
         clipsToBounds = true
     }
    
     func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
         return .none
     }

     private func presentationController(controller: UIPresentationController!, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController! {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
}
  
extension UINavigationBar {

    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
