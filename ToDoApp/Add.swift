//
//  Add.swift
//  ToDoApp
//
//  Created by aaron on 14-9-17.
//  Copyright (c) 2014年 The Technology Studio. All rights reserved.
//

import UIKit


@IBDesignable
class Add: UIViewController{
    
    let cellIdentifier = "Cell"
    
    var importance : Int = 3
    
    var itemCount : Int = 0
    
    @IBOutlet weak var importanceCtrl: UISegmentedControl!
    
    
    
    @IBOutlet var item: KCTextView!
    
    @IBOutlet var todo: UITextField!
    @IBOutlet var desc: KCTextView!
    @IBOutlet var time: UIDatePicker!
    @IBOutlet var completeBtn: UIButton!
    var delegate: AddProtocal?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    @IBAction func setImp(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            importance = 3
            break
        case 1:
            importance = 2
            break
        case 2:
            importance = 1
            break
        default:
            break
        }
    }

    
    func setup() {
        completeBtn.layer.cornerRadius = 5.0
        todo.placeholder = "Type what you want to do"
        desc.placeholder = "Description"
        item.placeholder = "Add some items"
        todo.text = self.todo.text
        desc.text = self.desc.text
        item.text = self.item.text
        time.date = self.time.date
        time.minimumDate = Date()
        
        if delegate == nil {
            todo.textColor = UIColor.lightGray
            todo.isUserInteractionEnabled = false
            desc.textColor = UIColor.lightGray
            desc.isUserInteractionEnabled = false
            item.textColor = UIColor.lightGray
            item.isUserInteractionEnabled = false
            time.isUserInteractionEnabled = false
            completeBtn.setTitle("OK", for: UIControlState())
        }else {
            todo.textColor = UIColor.black
            todo.isUserInteractionEnabled = true
            desc.textColor = UIColor.black
            desc.isUserInteractionEnabled = true
            item.textColor = UIColor.black
            item.isUserInteractionEnabled = true
            time.isUserInteractionEnabled = true
            completeBtn.setTitle("OK", for: UIControlState())
        }
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(Add.hideKeyboard))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.down
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)
        
       
    }
    
    func hideKeyboard() {
        print("swipeGesture....")
        todo.resignFirstResponder()
        desc.resignFirstResponder()
        item.resignFirstResponder()
    }
    
    func shakeAnimation(_ sender: AnyObject) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [NSNumber(value: 0),NSNumber(value: 1.0/6.0),NSNumber(value: 3.0/6.0),NSNumber(value: 5.0/6.0),NSNumber(value: 1)]
        
        animation.duration = 0.4
        animation.isAdditive = true
        sender.layer.add(animation, forKey: "shake")
    }
    
    
    
    @IBAction func completeTouch(_ sender: AnyObject) {
        if ((todo.text?.characters.count)! > 0){
            delegate?.didCompleted(self)
            self.dismiss(animated: true, completion: nil)
        }else{
            shakeAnimation(todo)
        }
    }
    @IBAction func editingDidEnd(_ sender: UITextField) {
        if (sender.text?.characters.count == 0) {
           shakeAnimation(todo)
        }
        
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        todo.resignFirstResponder()
        
        desc.resignFirstResponder()
        
        item.resignFirstResponder()
        
    }
    
}


