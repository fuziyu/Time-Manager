import UIKit


@IBDesignable
class Main: UIViewController, UITableViewDataSource, UITableViewDelegate, AddProtocal {
    

    @IBOutlet var tableView: UITableView!
    let cellIdentifier = "Cell"

    var toDoData = [Add]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCell()
    }
    
    func setup() {
        self.title = "Time Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(Main.addItem))
        
        NotificationCenter.default.addObserver(self, selector: #selector(Main.firstAction(_:)), name: NSNotification.Name(rawValue: "actionOnePressed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Main.secondAction(_:)), name: NSNotification.Name(rawValue: "actionTwoPressed"), object: nil)
    }
    
    func registerCell() {
        let bundle: Bundle = Bundle.main
        let nib: UINib = UINib(nibName: "Cell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    
    func addItem() {
        let addVC: Add = Add(nibName: "Add", bundle: nil)
        addVC.delegate = self;
        self.present(addVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell
        var _: String
        if (cell == nil) {
            let nibs:NSArray = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)! as NSArray
            cell = nibs.lastObject as? Cell
        }
        
        let addObject = toDoData[indexPath.row] as Add
        cell?.todoTitle.text = addObject.todo.text
        cell?.time.text = dateFormatter(addObject.time.date)
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        if addObject.importance == 3 {
            cell?.todoTitle.textColor = UIColor.red
        }
        
        else if addObject.importance == 2 {
            cell?.todoTitle.textColor = UIColor.yellow
        }
        
        else {
            cell?.todoTitle.textColor = UIColor.green
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addVC = toDoData[indexPath.row] as Add
        addVC.delegate = nil
        self.present(addVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            toDoData.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
 
    func didCompleted(_ addObject: Add) {
  
        toDoData.append(addObject)
        toDoData.sorted(by: { self.dateFormatter($0.time.date) < self.dateFormatter($1.time.date)})
        tableView.reloadData()
        
        let notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Notification: \(addObject.todo.text!)"
        notification.fireDate = addObject.time.date
        var dic:[String: Date] = ["fireDate":addObject.time.date]
        UIApplication.shared.scheduleLocalNotification(notification)

    }
    
    
    
    
    
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: NSGregorianCalendar)
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    
    func firstAction(_ notification: Notification) {
        print("知道了")
    }
    
    func secondAction(_ notification: Notification) {
        print("去看看")
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

