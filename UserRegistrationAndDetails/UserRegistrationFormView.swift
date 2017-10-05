//
//  FormDictionaryVC.swift
//  TableView
//
//  Created by JOY MONDAL on 8/31/17.
//  Copyright © 2017 OPTLPTP131. All rights reserved.
//

import UIKit



class FormDictionaryVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ProfileControllerDelegate
{
    let networkServiceManager = NetworkServiceManager()
    let profileController = ProfileController.shared()
    
    
    var segment:String = ""
    let imagePickerController = UIImagePickerController()
    let department = ["IOS","ANDROID","PHP","DOTNET","TESTING"]
    var dob = ""
    var photo = UIImage()
    var arrayOfDic = [NSDictionary]()
    // After search filtered Array of Dictionaries
    
    
    
    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var DataContentDatePickerView: UIView!
    @IBOutlet weak var DataContentPickerView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var segmentoutletaction: UISegmentedControl!
    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var imageviewlabel: UIImageView!
    @IBOutlet weak var pickerLabel: UILabel!
    
    @IBAction func addMainAction(_ sender: Any)
    {
        if checkingFields()
        {
            errorAlert()
        }
        else
        {
            profileController.firstName  = self.firstNameTextField.text
            profileController.lastName = self.lastNameTextField.text
            profileController.dob = dob
            profileController.gender = segment
            profileController.dept = pickerLabel.text
            
            DispatchQueue.global().async {
                let imageData: Data = UIImageJPEGRepresentation(self.imageviewlabel.image!, 0.5)!
                let strBase64 = imageData.base64EncodedString(options: .endLineWithCarriageReturn)
                self.profileController.photo = strBase64
                
                
                DispatchQueue.main.async {
                    
                    self.view.displayLoader()
                    self.profileController.delegate = self
                    self.profileController.handleAddUserProfileRequest()
                    
                }
            }
            
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            datePickerLabel.text = "Enter DOB"
            pickerLabel.text = "Enter Dept."
        }
    }
    
    //MARK:- Error Alert Showing Function
    
    func errorAlert()
    {
        let alertController = UIAlertController(title: "Enter The Full Credential", message: "Click", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    //Mark:- Checking All Field Field
    func checkingFields() -> Bool
    {
        let trimmedFirstName = (firstNameTextField.text)?.trimmingCharacters(in: .whitespaces)
        let trimmedLastName = (lastNameTextField.text)?.trimmingCharacters(in: .whitespaces)
        if ( (firstNameTextField.text?.isEmpty)! || trimmedFirstName?.characters.count==0 || (lastNameTextField.text?.isEmpty)! || trimmedLastName?.characters.count==0 || self.segmentoutletaction.selectedSegmentIndex == UISegmentedControlNoSegment || datePickerLabel.text == "Enter DOB" || pickerLabel.text == "Enter Dept.")
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    @IBAction func previewAction(_ sender: Any) {
        let secondVC = FormTableVC(nibName: "FormTableVC", bundle: nil)
        
        // secondVC.component = arrayOfDic
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        
        
    }
    @IBAction func ClickActionDatePicker(_ sender: Any) {
        
        
        DataContentDatePickerView.isHidden = false
        
        
    }
    
    
    
    @IBAction func cancelDatePicker(_ sender: Any) {
        
        self.view.endEditing(true)
        datePickerLabel.text = "Enter You DOB"
        DataContentDatePickerView.isHidden = true
        
    }
    
    
    @IBAction func doneDatePicker(_ sender: Any) {
        
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM yyyy"
        
        datePickerLabel.text = formatter.string(from: datePickerView.date)
        dob = formatter.string(from: datePickerView.date)
        DataContentDatePickerView.isHidden = true
        
        //dismiss date picker dialog
        self.view.endEditing(true)
        
        
    }
    
    
    @IBAction func clickActionPicker(_ sender: Any) {
        
        DataContentPickerView.isHidden = false
        
    }
    
    
    
    
    @IBAction func cancelPicker(_ sender: Any) {
        
        
        DataContentPickerView.isHidden = true
    }
    
    
    
    @IBAction func donePickerAction(_ sender: Any) {
        
        
        let pickervalue = department[pickerview.selectedRow(inComponent: 0)] as String
        pickerLabel.text = pickervalue
        
        
        
        DataContentPickerView.isHidden = true
    }
    
    @IBAction func imagePickerAction(_ sender: Any) {
        
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DataContentPickerView.isHidden = true
        DataContentDatePickerView.isHidden = true
        
        pickerview.dataSource = self
        pickerview.delegate = self
        //imageviewlabel.image = #imageLiteral(resourceName: "defaultImage")
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - deligate func of image picker;
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.imageviewlabel.image = pickedImage
            photo = pickedImage
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        imagePickerController.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return department.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return department[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    
    
    @IBAction func segmentAction(_ sender: Any) {
        
        switch segmentoutletaction.selectedSegmentIndex {
            
        case 0:
            
            segment = segmentoutletaction.titleForSegment(at: 0)!
            print(segment)
            break
        case 1:
            
            segment = segmentoutletaction.titleForSegment(at:1)!
            print(segment)
            break
        default:
            break
            
        }
        
        
    }
    
    
    func onSuccess(response:String)
    {
        self.view.hideLoader()
        let alert = UIAlertController(title: "", message: "Succesfully Updated", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func onFail(response:String)
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
