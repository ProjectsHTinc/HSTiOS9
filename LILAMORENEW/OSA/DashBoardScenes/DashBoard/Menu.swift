//
//  Menu.swift
//  OSA
//
//  Created by Happy Sanz Tech on 11/02/21.
//

import UIKit
import SDWebImage

class Menu: UIViewController, ProfileDetailsDisplayLogic {
   
    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userMailidLbl: UILabel!
    @IBOutlet weak var signInOutlet: UIButton!
    
    private var navigationBarWasHidden = false
    var interactor1: ProfileDetailsBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        interactor1?.fetchItems(request: ProfileDetailsModel.Fetch.Request( user_id:GlobalVariables.shared.customer_id))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        self.userPic.image(named:)
        // Save if it was hidden initially
        self.navigationBarWasHidden = self.navigationController?.isNavigationBarHidden ?? false
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
       
    }
    
   
    @IBAction func signInAction(_ sender: Any) {
        
        if signInOutlet.isEnabled == true {
            
            navigateToLogin ()
        }
    }
    
    func navigateToLogin () {
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "nav")
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
        let viewController1 = self
        let interactor1 = ProfileDetailsInteractor()
        let presenter1 = ProfileDetailsPresenter()
        viewController1.interactor1 = interactor1
        interactor1.presenter1 = presenter1
        presenter1.viewController1 = viewController1
    }
    
    func successFetchedItems(viewModel: ProfileDetailsModel.Fetch.ViewModel) {
        
        self.userPic.sd_setImage(with: URL(string:viewModel.profile_picture!), placeholderImage: UIImage(named: "profile"))
        self.userNameLbl.text = viewModel.first_name
        self.userMailidLbl.text = viewModel.phone_number
        signInOutlet.isEnabled = false
        signInOutlet.titleLabel!.text = ""
    }
    
    func errorFetchingItems(viewModel: ProfileDetailsModel.Fetch.ViewModel) {
        signInOutlet.isEnabled = true
//        signInOutlet.titleLabel!.text = "Sign In,"
        signInOutlet.setTitle("Hello,SignIn", for: .normal)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: Globals.alertTitle, message: "Are you sure want to log out", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
          
            GlobalVariables.shared.customer_id = ""
            GlobalVariables.shared.profile_picture = ""
            GlobalVariables.shared.phone_number = ""
            GlobalVariables.shared.first_name = ""
            GlobalVariables.shared.last_name = ""
            GlobalVariables.shared.email_Id = ""
            
            UserDefaults.standard.clearUserData()
            
            self.reNew()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reNew(){
            //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "nav")
    }
}

