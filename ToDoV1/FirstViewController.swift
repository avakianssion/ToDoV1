//  FirstViewController.swift
//  ToDoV1
//  Created by Sion Avakian on 7/5/17.
//  Copyright © 2017 Sion Avakian. All rights reserved.

import UIKit
import CoreData
import Foundation

var toDoList = [NSManagedObject]()
var timeList = [NSManagedObject]()
var doubleTimeList = [NSManagedObject]()

var timeSelection = ["10","15","20","25","30","35","40","45",
    "50","55","60","65","70","75","80","85","90","95","100",
    "105","110","115","120","125"]

var selectedTime  : String?
var completeTask = Int(UserDefaults.standard.double(forKey: "completeTask"))
var incompleteTask = Int(UserDefaults.standard.double(forKey: "incompleteTask"))

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UITextFieldDelegate  {
    
    @IBOutlet var topLabel: UILabel!
        @IBOutlet weak var tableView: UITableView!
    @IBOutlet var currentDate: UILabel!
    
    // text field and add button in goals page
    
    
        // hide keyboard when user touches outside the keyboard
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        // hide the keyboard when the user presses the return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        popUpTaskTextField.resignFirstResponder()
        return (true)
    }
/*
    @IBAction func segueButton(_ sender: UIButton) {
    tabBarController?.selectedIndex = 2
    
    }
    @IBAction func segueButton2(_ sender: UIButton) {
        tabBarController?.selectedIndex = 0

    }
    
  */
    

    // text field and add button end here
    
    func saveItem(itemToSave: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =
            NSEntityDescription.entity(forEntityName:"ListEntity", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(itemToSave, forKey: "item")
        
        do{
            try managedContext.save()
            toDoList.append(item)
        }
        catch {
            print("error")
        }

    }

    //function to save the time
    
    func saveTime (timeToSave: String) {
        let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
        let managedTime = appDelegate2.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TimeEntity", in: managedTime)
        let time = NSManagedObject(entity: entity!, insertInto: managedTime)
        time.setValue(timeToSave, forKey: "time")
        
        do {
            try managedTime.save()
            timeList.append(time)
        }
        catch {
            print("error")
        }
    }
    //function to save the time ends
    func saveDoubleTime (doubleTimeToSave: Double) {
        let appDelegate3 = UIApplication.shared.delegate as! AppDelegate
        let managedDoubleTime = appDelegate3.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "DoubleTimeEntity", in: managedDoubleTime)
        let doubleTime = NSManagedObject(entity: entity!, insertInto: managedDoubleTime)
        doubleTime.setValue(doubleTimeToSave, forKey: "doubleTime")
        
        do {
            try managedDoubleTime.save()
            doubleTimeList.append(doubleTime)
        }
        catch {
            print("error")
        }
    }
    // func save double time
    
    // func save double time ends
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (toDoList.count)
    }

    public func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let item = toDoList[indexPath.row]
        let time = timeList[indexPath.row]
        // time
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.detailTextLabel?.text = (time.value(forKey: "time") as? String)! + ":00"
        cell.textLabel?.text = item.value(forKey: "item") as? String
        cell.backgroundColor = UIColor.clear
       // cell.imageView?.clipsToBounds = true
        return (cell)

    
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
 
        //task
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //time
        let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
        let managedTime = appDelegate2.managedObjectContext
        //double time 
        let appDelegate3 = UIApplication.shared.delegate as! AppDelegate
        let managedDoubleTime = appDelegate3.managedObjectContext
        
        // delete
        let deleteAction = UITableViewRowAction(style: .default, title: "") { (action, indexPath) in
            
            tableView.isEditing = false
  
            tableView.reloadData()
              managedContext.delete(toDoList[indexPath.row])
               toDoList.remove(at: indexPath.row)
              managedTime.delete(timeList[indexPath.row])
                timeList.remove(at: indexPath.row)
            tableView.reloadData()
                managedDoubleTime.delete(doubleTimeList[indexPath.row])
                doubleTimeList.remove(at: indexPath.row)
            tableView.reloadData()

        // delete ends here
        }
        let img: UIImage = UIImage(named: "002-delete-2")!
        let imgSize: CGSize = tableView.frame.size
        UIGraphicsBeginImageContext(imgSize)
        img.draw(in: CGRect(x: 0, y: 10, width: 30, height: 30))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        deleteAction.backgroundColor = UIColor(patternImage: newImage)
        
      ///  deleteAction.backgroundColor = UIColor(patternImage: UIImage(named:"002-delete-1")!)

        
        return [deleteAction]
        
    }
    
    // timer pickerView
    func timePicker() {
        let timePicker = UIPickerView()
        timePicker.delegate = self
        
        popUpTimeTextField.inputView = timePicker

        
    // customization
    timePicker.backgroundColor = .white
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeSelection.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeSelection[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedTime = timeSelection[row]
        popUpTimeTextField.text = selectedTime
    }
    
    
    // toolbar for picker view
    func timePickerToolBar () {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
    // customization
        toolBar.barTintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Pick", style: .plain, target: self,
                                         action: #selector(FirstViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    
        popUpTimeTextField.inputAccessoryView = toolBar
    
    
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //appending task
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListEntity")
        do{
            let results = try managedContext.fetch(fetchRequest)
            toDoList = results as! [NSManagedObject]
        }
        catch {
            print("error")
        }
      
        
        //appending time
        let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
        let managedTime = appDelegate2.managedObjectContext

        let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeEntity")
        do{
            let results = try managedTime.fetch(fetchRequest1)
            timeList = results as! [NSManagedObject]
        }
        catch {
            print("error")
    
        }
        //appending doubleTime
        let appDelegate3 = UIApplication.shared.delegate as! AppDelegate
        let managedDoubleTime = appDelegate3.managedObjectContext
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "DoubleTimeEntity")
        do{
            let results = try managedDoubleTime.fetch(fetchRequest2)
            doubleTimeList = results as! [NSManagedObject]
        }
        catch {
            print("error")
            
        }


    }
    
    
    //toolbar for picker view ends
    //timer pickerView ends
    // blured pop up view to add task and time starts here
    
    @IBOutlet var popUpAdd: UIView!
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var popUpTaskTextField: UITextField!
    @IBOutlet var popUpTimeTextField: UITextField!
    func animateIn() {  // opens the add pop up
        self.view.addSubview(popUpAdd)
        popUpAdd.center = self.view.center
        popUpAdd.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUpAdd.alpha = 0
        
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.popUpAdd.alpha = 1
            self.popUpAdd.transform = CGAffineTransform.identity
            
        }
        
        
    }
    func animateOut () { // closes the add pop up
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpAdd.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpAdd.alpha = 0
            
            self.visualEffectView.isHidden = true
            
        }) { (success:Bool) in
            self.popUpAdd.removeFromSuperview()
        }
    }
    // blured pop up view to add task and time ends here
   /* @IBAction func trigerPopUpAdd(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func closePopUpCancel(_ sender: Any) {
        animateOut()

    }
    @IBAction func popUpAddButton(_ sender: Any) {
        
        if popUpTaskTextField.text != "" //&& popUpTimeTextField.text != ""
        {
            
            self.saveTime(timeToSave: popUpTimeTextField.text!)
            self.saveItem(itemToSave: popUpTaskTextField.text!)
            self.saveDoubleTime(doubleTimeToSave: Double(popUpTimeTextField.text!)!)
            
            
            print(incompleteTask)
            UserDefaults.standard.set(incompleteTask, forKey: "incompleteTask")
            incompleteTask = Int(UserDefaults.standard.double(forKey: "incompleteTask"))
            incompleteTask = incompleteTask + 1
            UserDefaults.standard.set(incompleteTask, forKey: "incompleteTask")
            print(incompleteTask)
            UserDefaults.standard.synchronize()
            
            

            popUpTaskTextField.text = ""
            popUpTimeTextField.text = ""
            
            //   timeList.append(timerTextField.text!)
            // toDoList.append(taskTextField.text!)
            
        }
        
        tableView.reloadData()
        animateOut()
    }
    
   
*/

      override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.isHidden = true
     //   popUpAdd.layer.cornerRadius = 5
     //   timePicker()
     //   timePickerToolBar()
     //   popUpTaskTextField.delegate = self
        topLabel.text = "Daily Goals"
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy" 
        let result = formatter.string(from: date as Date)
        currentDate.text = String(result)
   /*
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
       
        
        
        // Do any additional setup after loading the view.
    /*
        }
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.tabBarController?.selectedIndex)! < 3 { // set your total tabs here
                self.tabBarController?.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if (self.tabBarController?.selectedIndex)! > 0 {
                self.tabBarController?.selectedIndex -= 1
            }
        }
    }
 */
  

   */
        func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
}
