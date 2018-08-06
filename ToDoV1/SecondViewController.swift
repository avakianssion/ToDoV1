//
//  SecondViewController.swift
//  ToDoV1
//
//  Created by Sion Avakian on 6/27/17.
//  Copyright © 2017 Sion Avakian. All rights reserved.
//

import UIKit
import CoreData

var initMinutes = 10
var minutes = 10
var seconds = 60

class SecondViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource
{
    var numOfWatts = Int(UserDefaults.standard.double(forKey: "numOfWatts"))

    @IBOutlet var tabBar: UITabBarItem!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var openCollectionViewOutlet: UIButton!
    
    @IBOutlet var popUpTextField: UITextField!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide the keyboard when the user presses the return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        popUpTextField.resignFirstResponder()
        return (true)
    }

    var timer = Timer()
    
    @IBOutlet var lable: UILabel!

    /*
    @IBAction func segueButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    
    }
    */
    
    
    
    @IBOutlet var increaseTimeOutlet: UIButton!
    @IBOutlet var decreaseTimeOutlet: UIButton!
    
    @IBAction func increaseTime(_ sender: Any) {
    
    //initMinutes = 10
        if (initMinutes < 10)
        {
            initMinutes = 10
        }
        else if (initMinutes >= 125)
        {
            initMinutes = 120
        }

        initMinutes += 5
        lable.text = String(initMinutes) + ":00"
    }
  
    @IBAction func decreaseTime(_ sender: Any) {
        if (initMinutes < 10)
        {
            initMinutes = 10
        }
        else if (initMinutes >= 125)
        {
            initMinutes = 120
        }

        initMinutes -= 5
        lable.text = String(initMinutes) + ":00"

    }
    
    @IBOutlet var startOutlet: UIButton!
    
    // function start and stop combined in one power button
    @IBAction func start(_ sender: UIButton) {
    
        increaseTimeOutlet.isHidden = true
        decreaseTimeOutlet.isHidden = true
        startOutlet.isHidden = true
       
        animateIn()
        minutes = initMinutes
        minutes -= 1
        /*
        sender.tag += 1
        if sender.tag > 2 { sender.tag = 1 }
        
        switch sender.tag {
        case 1:
            animateIn()
            minutes = initMinutes
            minutes -= 1
      //      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)

        break
        case 2:
            animateInwarningView()
       /*     timer.invalidate()
            seconds = 60
           // initMinutes = 10
          //  minutes = 10
            lable.text = String(initMinutes) + ":00"
            increaseTimeOutlet.isHidden = false
            decreaseTimeOutlet.isHidden = false
            popUpTextField.text = ""
            
                increaseTimeOutlet.isHidden = false
                decreaseTimeOutlet.isHidden = false
                popUpTextField.text = ""
        */
        break
        default:
            print("THIS IS A TEST")
        }
 
 */
    }
    
    // function start and stop combined in one power button ends here


    @objc func counter() // function to countdown the time
    {
              seconds -= 1
    

        lable.text = String(seconds)
        if (seconds == 0)
        {
            seconds = 59
            minutes -= 1
        }
        
        lable.text = String(minutes) + ":" + String(seconds)
        
        
        if (minutes < 1)
        {
            lable.text = String(seconds)
            if (minutes < 0)
            {
            timer.invalidate()
            seconds = 0
            lable.text =  String(seconds)
            startOutlet.isHidden = false

            self.saveTime(timeToSave:String(initMinutes))
                
            // sends the task to Goals Page
                if popUpTextField.text != "" && minutes < 0
                {
            self.saveItem(itemToSave: popUpTextField.text!)
                    print(completeTask)
                    UserDefaults.standard.set(completeTask, forKey: "completeTask")
                    completeTask = Int(UserDefaults.standard.double(forKey: "completeTask"))
                    completeTask = completeTask + 1
                    UserDefaults.standard.set(completeTask, forKey: "completeTask")
                    print(completeTask)
                    UserDefaults.standard.synchronize()
                
            numOfWatts = numOfWatts + 5
            UserDefaults.standard.set(numOfWatts, forKey: "numOfWatts")  // save the number of watts to device
            UserDefaults.standard.synchronize()
            WattsLabel.text = String(numOfWatts)     // assign number of watts
            WattsLabelTimerPage.text = String (numOfWatts)  // assign number of watts
                    increaseTimeOutlet.isHidden = false
                    decreaseTimeOutlet.isHidden = false
                    cancelButton.isHidden = true
                    startOutlet.isHidden = false
                    popUpTextField.text = ""
                }
            }
        }
    
    } // end counter
    
    // save Item 
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
      //    toDoList(item).textColor = UIColor.red()
        }
        catch {
            print("error")
        }
        
    }

// save Item end
// save time 
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
    
// save time end
// blured out pop up box to save the activity starts here
    
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    var effect:UIVisualEffect!
    
// blured out pop up box to save the activity ends here

   
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.isHidden = true
     //   self.tabBarController!.tabBar.backgroundColor = UIColor.clear
     //   self.tabBarController!.tabBar.isTranslucent = true

        visualEffectView.isHidden = true
        popUpTextField.delegate = self
        popUpView.layer.cornerRadius = 5
        

    //    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    //    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
    //    self.view.addGestureRecognizer(swipeLeft)
        
        customCollection.dataSource = self
        customCollection.delegate = self
        
        UserDefaults.standard.set(numOfWatts, forKey: "numOfWatts")  // save the number of watts to device
        UserDefaults.standard.synchronize()

        WattsLabel.text = String(numOfWatts)     // assign number of watts
        WattsLabelTimerPage.text = String (numOfWatts)  // assign number of watts
        warningLabel.text = "Are you sure you want to stop the task?"
        // Do any additional setup after loading the view.
     //   self.tabBarController?.tabBar.isHidden = true

    }
    /*
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
    
    func animateIn() {        // pop up new page to add item
        self.view.addSubview(popUpView)
        popUpView.center = self.view.center
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut () {    // close the new page for adding item
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0
            
           self.visualEffectView.isHidden = true
            
        }) { (success:Bool) in
            self.popUpView.removeFromSuperview()
        }
    }
    
    @IBAction func dismissPopUpCancelButton(_ sender: Any) {
        animateOut()
        startOutlet.isHidden = false
        decreaseTimeOutlet.isHidden = false
        increaseTimeOutlet.isHidden = false
        openCollectionViewOutlet.isHidden = false
    }
    @IBAction func dismissPopUp(_ sender: Any) {
        
        openCollectionViewOutlet.isHidden = true
        animateOut()
        if (popUpTextField.text != "")
        {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)
    
        }
        cancelButton.isHidden = false

    }
   
    @IBAction func OpenCollectionView(_ sender: UIButton) {
    animateInCollectionView()
    
    }

    // Collection View//////////////////////
    @IBOutlet var collectionView: UIView!
    
    func animateInCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.center = self.view.center
        collectionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        collectionView.alpha = 0
       
        
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
            self.collectionView.transform = CGAffineTransform.identity
        }
    }
    func animateOutCollectioView (){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.collectionView.alpha = 0
            
            
        }) { (success:Bool) in
            self.collectionView.removeFromSuperview()
        }
    }
    
    @IBAction func CloseCollectionView(_ sender: UIButton) {  // button to close the CollectionView
    
    animateOutCollectioView()
    
    }
    @IBOutlet weak var characterImage: UIImageView!  // outlet used to change the chartacter image
    
    // Pop Up Collection View Entire Code Starts Here
    
    let collectionViewImages = ["solar-panel", "solar-panel", "solar-panel", "power-plant","power-plant","power-plant","wind-turbine","wind-turbine","wind-turbine"]
    
    
    @IBOutlet weak var customCollection: UICollectionView!
    // set up collection view
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewImages.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
    
        cell.imageCell.image = UIImage(named: collectionViewImages[indexPath.row])

        cell.backgroundColor = UIColor.clear
        
        cell.layer.borderColor = UIColor (red: 157.0/255.0, green: 156.0/255.0, blue: 176.0/255.0, alpha: 1.0).cgColor
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 8
        return cell
    }
    // select a cell in collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 0
        
        cell?.layer.borderColor = UIColor (red: 132.0/255.0, green: 188.0/255.0, blue: 121.0/255.0, alpha: 1.0).cgColor
        
        // background color
        
        cell?.layer.backgroundColor = UIColor (red: 86.0/255.0, green: 132.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor
        // change characterImage
        characterImage.image = UIImage(named: collectionViewImages[indexPath.row])
    }

    
    /// User releases touching the cell
   
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.backgroundColor = UIColor.clear
        
        cell?.layer.borderColor = UIColor (red: 157.0/255.0, green: 156.0/255.0, blue: 176.0/255.0, alpha: 1.0).cgColor
        cell?.layer.borderWidth = 0
        cell?.layer.cornerRadius = 8
        
    }
    

    
    @IBAction func purchaseButton(_ sender: UIButton) {

    }


    // label for number of watts
   
    
    @IBOutlet weak var WattsLabel: UILabel!
    @IBOutlet weak var WattsLabelTimerPage: UILabel!
    
    // Pop Up view to warn ther user before stoping a running timer
    
    @IBOutlet var warningView: UIView!
    
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBAction func continueButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60
        // initMinutes = 10
        //  minutes = 10
        lable.text = String(initMinutes) + ":00"
        increaseTimeOutlet.isHidden = false
        decreaseTimeOutlet.isHidden = false
        cancelButton.isHidden = true
        startOutlet.isHidden = false
        popUpTextField.text = ""
        numOfWatts = numOfWatts - 2
        UserDefaults.standard.set(numOfWatts, forKey: "numOfWatts")  // save the number of watts to device
        UserDefaults.standard.synchronize()
        
        incompleteTask = incompleteTask + 1
        UserDefaults.standard.set(incompleteTask, forKey: "incompleteTask")
        UserDefaults.standard.synchronize()
        
        increaseTimeOutlet.isHidden = false
        decreaseTimeOutlet.isHidden = false
        popUpTextField.text = ""
        openCollectionViewOutlet.isHidden = false
        animateOutwarningView()
        
        
        
        

    }
    @IBAction func cancelButton(_ sender: UIButton) {
    
        animateOutwarningView()
    }
    
    
    @IBAction func cancelTimerButton(_ sender: UIButton) {
        animateInwarningView()

    }
    
    
    
    func animateInwarningView() {
        self.visualEffectView.isHidden = false
        self.view.addSubview(warningView)
        warningView.center = self.view.center
        warningView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        warningView.alpha = 0
        
        
        UIView.animate(withDuration: 0.4) {
            self.warningView.alpha = 1
            self.warningView.transform = CGAffineTransform.identity
        }
    }
    func animateOutwarningView (){
        self.visualEffectView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.warningView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.warningView.alpha = 0
            
            
        }) { (success:Bool) in
            self.warningView.removeFromSuperview()
        }
    }
    
    
    
    
    
    // end Pop Up view to warn ther user before stoping a running timer

    
    
    // Pop Up Collection View Entire Code Ends here
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




































