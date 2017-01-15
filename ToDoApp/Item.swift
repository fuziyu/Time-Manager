//
//  Item.swift
//  ToDoApp
//
//  Created by Apple on 16/12/20.
//  Copyright © 2016年 The Technology Studio. All rights reserved.
//


import UIKit

protocol AddProtocal {
    func didCompleted(_ addObject: Add)
}

@IBDesignable
class Item: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    let cellIdentifier = "Cell"
    
    var importance : Int = 3
    
    var itemCount : Int = 0
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell
        var _: String
        if (cell == nil) {
            let nibs:NSArray = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)! as NSArray
            cell = nibs.lastObject as? Cell
        }
        
//        let addObject = toDoData[indexPath.row] as Add
//        cell?.todoTitle.text = addObject.todo.text
//        cell?.time.text = dateFormatter(addObject.time.date)
//        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        
//        if addObject.importance == 3 {
//            cell?.todoTitle.textColor = UIColor.red
//        }
//            
//        else if addObject.importance == 2 {
//            cell?.todoTitle.textColor = UIColor.yellow
//        }
//            
//        else {
//            cell?.todoTitle.textColor = UIColor.green
//        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
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
    
    
    
    func setup() {
//        completeBtn.layer.cornerRadius = 5.0
//        todo.placeholder = "请输入待办日程"
//        desc.placeholder = "请输入详细描述"
//        todo.text = self.todo.text
//        desc.text = self.desc.text
//        time.date = self.time.date
//        time.minimumDate = Date()
//        
//        if delegate == nil {
//            todo.textColor = UIColor.lightGray
//            todo.isUserInteractionEnabled = false
//            desc.textColor = UIColor.lightGray
//            desc.isUserInteractionEnabled = false
//            time.isUserInteractionEnabled = false
//            completeBtn.setTitle("OK", for: UIControlState())
//        }else {
//            todo.textColor = UIColor.black
//            todo.isUserInteractionEnabled = true
//            desc.textColor = UIColor.black
//            desc.isUserInteractionEnabled = true
//            time.isUserInteractionEnabled = true
//            completeBtn.setTitle("Finish", for: UIControlState())
//        }
//        
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(Add.hideKeyboard))
//        swipeGesture.direction = UISwipeGestureRecognizerDirection.down
//        swipeGesture.numberOfTouchesRequired = 1
//        self.view.addGestureRecognizer(swipeGesture)
        
        
    }
    
    func hideKeyboard() {
        print("swipeGesture....")
        //todo.resignFirstResponder()
        //desc.resignFirstResponder()
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
    
    
    
    
//    @IBAction func completeTouch(_ sender: AnyObject) {
//        if ((todo.text?.characters.count)! > 0){
//            delegate?.didCompleted(self)
//            self.dismiss(animated: true, completion: nil)
//        }else{
//            shakeAnimation(todo)
//        }
//    }
    
    
//    @IBAction func editingDidEnd(_ sender: UITextField) {
//        if (sender.text?.characters.count == 0) {
//            shakeAnimation(todo)
//        }
//        
//    }
//    
}

