//
//  DateSetCVCell.swift
//  Eezy_UI_Task
//
//  Created by Sachin Bhandari on 13/06/20.
//  Copyright © 2020 Sachin Bhandari. All rights reserved.
//

import UIKit

class DateSetCVCell: UICollectionViewCell {
    
    @IBOutlet weak var mondayBtn: UIButton!
    @IBOutlet weak var tuesdayBtn: UIButton!
    @IBOutlet weak var wednesdayBtn: UIButton!
    @IBOutlet weak var thursdayBtn: UIButton!
    @IBOutlet weak var fridayBtn: UIButton!
    @IBOutlet weak var saturdayBtn: UIButton!
    @IBOutlet weak var sundayBtn: UIButton!
        
    var btnList: [UIButton]!

    let formatter = DateFormatter()


    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnList = [mondayBtn, tuesdayBtn, wednesdayBtn, thursdayBtn, fridayBtn, saturdayBtn, sundayBtn]
        
        for btn in btnList {
            btn.addTarget(self, action: #selector(self.selectBtn(_:)), for: .touchUpInside)
        }

        let today = Date.today()
        setTodaysDate(select: today)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.selection(notification:)), name: NSNotification.Name(rawValue: "DateSelect"), object: nil)


    }
    
    func setTodaysDate(select: Date) {
//        let today = Date.today()
        formatter.dateFormat = "E"
        let d = formatter.string(from: select)
        if d == "Mon" {
            self.selectBtn(self.mondayBtn)
        } else if d == "Tue" {
            self.selectBtn(self.tuesdayBtn)
        } else if d == "Wed" {
            self.selectBtn(self.wednesdayBtn)
        } else if d == "Thu" {
            self.selectBtn(self.thursdayBtn)
        } else if d == "Fri" {
            self.selectBtn(self.fridayBtn)
        } else if d == "Sat" {
            self.selectBtn(self.saturdayBtn)
        } else if d == "Sun" {
            self.selectBtn(self.sundayBtn)
        }
    }
    
    @objc func selectBtn(_ sender: UIButton) {
        
        for btn in btnList {
            btn.backgroundColor = lightGreen
            btn.setTitleColor(.darkGray, for: .normal)
            if sender == btn {
                btn.backgroundColor = selectedGreen
                btn.setTitleColor(.white, for: .normal)
            }
        }
        
    }
    
    
    func setDates(dates: [Date]) {
//        self.weekDatesList = dates
        for i in 0..<self.btnList.count {
            formatter.dateFormat = "dd"
            self.btnList[i].setTitle("\(formatter.string(from: dates[i]))", for: .normal)
            
            formatter.dateFormat = "E dd, MMMM yyyy"
            self.btnList[i].accessibilityHint = formatter.string(from: dates[i])
        }

    }
    
    @objc func selection(notification: Notification) {
        if let strDate = notification.userInfo?["Date"] as? String {
            print("\(strDate)")
//            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            if let date = formatter.date(from: strDate)  {
                setTodaysDate(select: date)
            }
        }
    }

}
