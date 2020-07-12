//
//  BigTableViewCell.swift
//  Todo
//
//  Created by Fengpeng Huang on 2020-06-17.
//  Copyright © 2020 Patrick. All rights reserved.
//

import UIKit
import TableViewDragger
import SwipeCellKit
import ChameleonFramework

class BigTableViewCell: UITableViewCell {
    //iboutlet declear here
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //global variable
    var scrollDelegate: myProtocol?
    var dragger: TableViewDragger?
    var deletable = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        dragger = TableViewDragger(tableView: tableView)
        dragger?.dataSource = self
        dragger?.delegate = self
        dragger?.alphaForCell = 0.7

        // Configure the view for the selected state
        tableView.dataSource = self
        tableView.rowHeight = 60.0
        tableView.register(UINib(nibName: "SwipeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    var imageNames = ["Home", "School", "Important", "Love"]
    
}

//MARK: - SipeCellKit Part
extension BigTableViewCell: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if(!deletable){
            return nil
        }
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

            //self.updateModel(indexPath)
            print("deleted")
            self.imageNames.remove(at: indexPath.row)
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash_Icon")

        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
}


//MARK: - TableView Part
extension BigTableViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        
        cell.delegate = self
        
        cell.textLabel?.text = "    "+imageNames[indexPath.row]
        
        
        //please remember to update the datastructure here:
        let cellImg : UIImageView = UIImageView(frame: CGRect(x: 10, y: 24, width: 12, height: 12))
        cellImg.image = UIImage(named: "blank-square-png-2")
        cellImg.layer.cornerRadius = 6
        cellImg.layer.masksToBounds = true
        cellImg.backgroundColor = UIColor.randomFlat()
        cell.addSubview(cellImg)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected a row")
    }

}


//MARK: - Dragger Part
extension BigTableViewCell: TableViewDraggerDataSource, TableViewDraggerDelegate{
    
    func dragger(_ dragger: TableViewDragger, moveDraggingAt indexPath: IndexPath, newIndexPath: IndexPath) -> Bool {
        print("hihi")

        let iamgeName = imageNames[indexPath.row]
        imageNames.remove(at: indexPath.row)
        imageNames.insert(iamgeName, at: newIndexPath.row)

        tableView.moveRow(at: indexPath, to: newIndexPath)
        
        return true
    }
    
    func dragger(_ dragger: TableViewDragger, willBeginDraggingAt indexPath: IndexPath) {
        scrollDelegate!.disableScrolling()
        //self.tableView.isScrollEnabled = true
        deletable = false

    }
    
    func dragger(_ dragger: TableViewDragger, didEndDraggingAt indexPath: IndexPath) {
        scrollDelegate!.enableScrolling()
        self.tableView.isScrollEnabled = false
        deletable = true
    }
    
    func dragger(_ dragger: TableViewDragger, shouldDragAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

}


//MARK: - Realm Part
//extension BigTableViewCell{
//    func updateModel(_ indexPath:IndexPath) {
//        imageNames = ["1", "2", "3", "4"]
//        tableView.reloadData()
//    }
//}
