//
//  FormTableVC.swift
//  TableView
//
//  Created by JOY MONDAL on 9/1/17.
//  Copyright © 2017 OPTLPTP131. All rights reserved.
//

import UIKit

class FormTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ProfileControllerDelegate {
     let profileController = ProfileController.shared()

    @IBOutlet weak var tableView: UITableView!
     let networkServiceManager = NetworkServiceManager()
  
    var component = [UserProfileBaseClass]()
  
    var filterArrayOfDictionaries = [UserProfileBaseClass]()
    var displayArray = [UserProfileBaseClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        self.displayArray = self.profileController.allUserDetails
        // Do any additional setup after loading the view.
        
        
        self.view.displayLoader()
        profileController.delegate = self
        profileController.handleGetUserProfileRequest()
            
            
            
        }
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "FormCellVCTableViewCell"
        
        var cell : FormCellVCTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FormCellVCTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "FormCellVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FormCellVCTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FormCellVCTableViewCell
            
        }
        let dictionary = displayArray[indexPath.row]
        let Age = dictionary.dob
        let firstname = dictionary.firstName
        let lastname = dictionary.lastName
        
        let dept = dictionary.dept
        let strBase64 = dictionary.photo
        if let dataDecoded : Data = Data(base64Encoded: strBase64! , options: .ignoreUnknownCharacters)
        {
            let decodedimage = UIImage(data: dataDecoded)
            cell?.profilePic.image = decodedimage
        }
        
        
        
        cell?.ageLabel.text = Age
        cell?.nameLabel.text = (firstname)!+" "+(lastname)!
        cell?.departmentLabel.text = dept
     
        
        
      
        
        
        return cell!
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty == true
        {
            self.displayArray = self.profileController.allUserDetails
        
        }
        else
        {
            filterArrayOfDictionaries = self.profileController.allUserDetails.filter { text in
            let name = text.firstName! + " " + text.lastName!
            return (name.lowercased().contains(searchText.lowercased()))
            }
        }
        
        self.displayArray = self.filterArrayOfDictionaries
        self.tableView.reloadData()
    }
    func onSuccess(response: String)
    {
        self.view.hideLoader()
        displayArray = profileController.allUserDetails
        self.tableView.reloadData()
        
    }
    
    func onFail(response: String)
    {
        self.view.hideLoader()
        
        let alert = UIAlertController(title: "", message: response, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }

}


