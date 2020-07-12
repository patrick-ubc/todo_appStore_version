//
//  ProgressBarViewCell.swift
//  Todo
//
//  Created by Fengpeng Huang on 2020-06-18.
//  Copyright © 2020 Patrick. All rights reserved.
//

import UIKit
import FSCalendar

class ProgressBarViewCell: FSCalendarCell {
    let first = CAShapeLayer()
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let center = self.contentView.center
        let center = CGPoint.init(x: frame.height / 2, y: frame.width / 2)
        //let center = CGPoint(x: bounds.midX, y: bounds.midY)
        print(frame.height)
        print(frame.width)
        //label.center = CGPoint(x: 160, y: 285)
        label.center = center
//        label.center.x = center.x
//        label.center.y = center.y
        
        label.textAlignment = NSTextAlignment.center;
        label.text = ""
        label.backgroundColor = UIColor.blue
        self.addSubview(label)


        //first
        //create track layer
        let firsttrack = CAShapeLayer()
        let circularPath_first = UIBezierPath(arcCenter: center, radius: 12, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        firsttrack.path = circularPath_first.cgPath

        firsttrack.strokeColor = UIColor.lightGray.cgColor
        firsttrack.lineWidth = 5

        firsttrack.fillColor = UIColor.clear.cgColor

        firsttrack.lineCap = .round
        self.layer.addSublayer(firsttrack)


        // drawing a circle somehow
        let path_first = UIBezierPath(arcCenter: center, radius: 12, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/3, clockwise: true)

        first.path = path_first.cgPath

        first.strokeColor = UIColor.orange.cgColor
        first.lineWidth = 5

        first.fillColor = UIColor.clear.cgColor

        first.lineCap = .round

        first.strokeEnd = 0

        self.layer.addSublayer(first)

    }

    func handler(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1

        basicAnimation.duration = 2

        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        first.add(basicAnimation, forKey: "Basic")

    }

}



//import UIKit
//import FSCalendar
//
//class ProgressBarViewCell: FSCalendarCell {
//    let first = CAShapeLayer()
//    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        let center = self.center
//        //let center = CGPoint(x: bounds.midX, y: bounds.midY)
//
//        //label.center = CGPoint(x: 160, y: 285)
//        label.center = center
////        label.center.x = center.x
////        label.center.y = center.y
//
//        label.textAlignment = NSTextAlignment.center;
//        label.text = ""
//        label.backgroundColor = UIColor.blue
//        self.addSubview(label)
//
//
//        //first
//        //create track layer
//        let firsttrack = CAShapeLayer()
//        let circularPath_first = UIBezierPath(arcCenter: center, radius: 12, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
//        firsttrack.path = circularPath_first.cgPath
//
//        firsttrack.strokeColor = UIColor.lightGray.cgColor
//        firsttrack.lineWidth = 5
//
//        firsttrack.fillColor = UIColor.clear.cgColor
//
//        firsttrack.lineCap = .round
//        self.layer.addSublayer(firsttrack)
//
//
//        // drawing a circle somehow
//        let path_first = UIBezierPath(arcCenter: center, radius: 12, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/3, clockwise: true)
//
//        first.path = path_first.cgPath
//
//        first.strokeColor = UIColor.orange.cgColor
//        first.lineWidth = 5
//
//        first.fillColor = UIColor.clear.cgColor
//
//        first.lineCap = .round
//
//        first.strokeEnd = 0
//
//        self.layer.addSublayer(first)
//
//    }
//
//    func handler(){
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        basicAnimation.toValue = 1
//
//        basicAnimation.duration = 2
//
//        basicAnimation.fillMode = .forwards
//        basicAnimation.isRemovedOnCompletion = false
//        first.add(basicAnimation, forKey: "Basic")
//
//    }
//
//}
