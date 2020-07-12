//
//  ViewController.swift
//  Todo
//
//  Created by Fengpeng Huang on 2020-06-17.
//  Copyright © 2020 Patrick. All rights reserved.
//

import UIKit
import FSCalendar

class FirstViewController: UIViewController {
    //iboutlet declear here:
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButton: UIButton!
    
    //global variabole here
    
    //calendar part:
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup fscalendar
        calendar.delegate = self
        calendar.dataSource = self

        self.calendar.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .week
        self.calendar.accessibilityIdentifier = "calendar"
        
        
        //setup collection View + make table view constrains resizable
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "HabitCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HabitCollectionViewCell")
        // Here still need to resize the table view if collection view is empty
        
        
        //setup Table View
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = 140.0
        tableView.register(UINib(nibName: "BigTableViewCell", bundle: nil), forCellReuseIdentifier: "BigTableViewCell")
        
        //size and shape of add button
        addButton.layer.cornerRadius = addButton.frame.height/2
        addButton.layer.shadowOpacity = 0.35
        addButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        addButton.layer.shadowRadius = 5
        
        if #available(iOS 13, *){
            if(traitCollection.userInterfaceStyle == .light){
                addButton.layer.shadowColor = UIColor.black.cgColor
                if let image = UIImage(named: "add_white"){
                    addButton.setImage(image, for: .normal)
                }
            }else{
                addButton.layer.shadowColor = UIColor.lightGray.cgColor
                if let image = UIImage(named: "add_black"){
                    addButton.setImage(image, for: .normal)
                }
            }
        }else{
            addButton.layer.shadowColor = UIColor.black.cgColor
            if let image = UIImage(named: "add_white"){
                addButton.setImage(image, for: .normal)
            }
        }
        
    }

    
    @IBAction func addPressed(_ sender: UIButton) {
        print("Pressing Add Button")
    }
    

}

//MARK: - Calendar Part
extension FirstViewController: FSCalendarDelegate,FSCalendarDataSource, FSCalendarDelegateAppearance, UIGestureRecognizerDelegate{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let day: Int! = self.gregorian.component(.day, from: date)
        if day%5 == 0{
            return day/5
        }else if day%4 == 0{
            return 3
        }else{
            return 0
        }
    }

    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let day: Int! = self.gregorian.component(.day, from: date)
        if day%4 == 0 {
            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
        }
        return nil
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
}


//MARK: - CollectionView Part
extension FirstViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    //specify how big is the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as! HabitCollectionViewCell
        return cell
    }
    
    
}



//MARK: - TableView Part
extension FirstViewController: myProtocol{
    func disableScrolling() {
        self.tableView.isScrollEnabled = false
    }
    
    func enableScrolling() {
        self.tableView.isScrollEnabled = true
    }
    
    
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BigTableViewCell", for: indexPath) as! BigTableViewCell
        
        cell.label.text = "Hi i am title"
        
        cell.scrollDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //20 for add buttom!!
        let height:CGFloat = CGFloat(300)
        return height
    }
    
}


//MARK: - Realm setup

