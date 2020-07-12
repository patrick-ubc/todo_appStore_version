//
//  SecondViewController.swift
//  Todo
//
//  Created by Fengpeng Huang on 2020-06-17.
//  Copyright © 2020 Patrick. All rights reserved.
//


//import UIKit
//import FSCalendar
//
//class SecondViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//}

import UIKit
import FSCalendar

class SecondViewController: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    
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

        calendar.delegate = self
        calendar.dataSource = self
        self.calendar.addGestureRecognizer(self.scopeGesture)
        calendar.collectionView.register(UINib(nibName: "ProgressBarViewCell", bundle: nil), forCellWithReuseIdentifier: "ProgressBarViewCell")
    }
    

    var delete = true
}


//MARK: - FSCalendar Part
extension SecondViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UIGestureRecognizerDelegate{
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return ""
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "ProgressBarViewCell", for: date, at: position) as! ProgressBarViewCell
        
        let weekday: Int! = self.gregorian.component(.weekday, from: date)
        
        if(delete){
            cell.backgroundColor = UIColor.red
            delete = false
        }
        
        if(weekday == 1){
            cell.label.text = "S"
        }else if(weekday == 2){
            cell.label.text = "M"
        }else if(weekday == 3){
            cell.label.text = "T"
        }else if(weekday == 4){
            cell.label.text = "W"
        }else if(weekday == 5){
            cell.label.text = "T"
        }else if(weekday == 6){
            cell.label.text = "F"
        }else{
            cell.label.text = "S"
        }
        
        
        cell.handler()
        return cell
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}
