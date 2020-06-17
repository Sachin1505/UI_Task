//
//  FirstVC.swift
//  Eezy_UI_Task
//
//  Created by Sachin Bhandari on 05/06/20.
//  Copyright © 2020 Sachin Bhandari. All rights reserved.
//

import UIKit

let lightGreen = UIColor(red: 210.0/255.0, green: 247.0/255.0, blue: 249.0/255.0, alpha: 1.0)
let selectedGreen = UIColor(red: 0/255.0, green: 207.0/255.0, blue: 216.0/255.0, alpha: 1.0)
let highlightGreen = UIColor(red: 0/255.0, green: 194.0/255.0, blue: 108.0/255.0, alpha: 1.0)
let bgGray = UIColor(red: 237.0/255.0, green: 240.0/255.0, blue: 245.0/255.0, alpha: 1.0)


class FirstVC: UIViewController {

    @IBOutlet weak var weekCollection: UICollectionView!
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var myStack: UIStackView!
    @IBOutlet weak var selectedDateLbl: UILabel!
    
    
    @IBOutlet weak var eveningView: UIView!
    @IBOutlet weak var eveningView2: UIView!
    @IBOutlet weak var hostView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var restuarantView: UIView!
    @IBOutlet weak var insideBarView: UIView!
    @IBOutlet weak var insideRestuarantView: UIView!
    @IBOutlet weak var msgView: UIView!
    
    @IBOutlet weak var acceptBtn1: UIButton!
    @IBOutlet weak var acceptBtn2: UIButton!
    @IBOutlet weak var acceptView1: UIView!
    @IBOutlet weak var acceptView2: UIView!

    @IBOutlet weak var declineBtn1: UIButton!
    @IBOutlet weak var declineBtn2: UIButton!
    @IBOutlet weak var declineView1: UIView!
    @IBOutlet weak var declineView2: UIView!
    
    @IBOutlet weak var eveImg: UIImageView!
    @IBOutlet weak var nigImg: UIImageView!

    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subContentViewHeight: NSLayoutConstraint!

    var isShowingAll = false
    
    var weekDatesArray = [[Date]]()
    var today = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.weekCollection.register(UINib(nibName: "DateSetCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")


        self.LoadTheCalendar()

//        self.acceptBtn2.addTarget(self, action: #selector(self.acceptInvite2(_:)), for: .touchUpInside)
//        self.declineBtn2.addTarget(self, action: #selector(self.declineInvite2(_:)), for: .touchUpInside)
        
        self.changeImageTint(img: self.eveImg)
        self.changeImageTint(img: self.nigImg)
        
    }
    
    func changeImageTint(img: UIImageView) {
        img.image = img.image?.withRenderingMode(.alwaysTemplate)
        img.tintColor = UIColor.darkGray
    }
    
    
    private func LoadTheCalendar() {
        today = Date.today()
        self.setDate(date: today)
        for i in 0...52 {
            let item = dateManager(today)
            self.weekDatesArray.insert(item, at: i)
            today = today.next(.monday)
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.myScroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1500)
        
        self.subContentViewHeight.constant = 1500
    }
    
    
    @IBAction func hideShowViews(_ sender: UIButton) {
        
        if self.isShowingAll {
            self.isShowingAll = false
            self.stackviewSetup(eveningView: false, eveningView2: true, hostView: true, barView: true, restuarantView: true, msgView: true)
            self.myStack.reloadInputViews()
        } else {
            self.isShowingAll = true
            self.stackviewSetup(eveningView: true, eveningView2: false, hostView: false, barView: false, restuarantView: false, msgView: false)
            self.myStack.reloadInputViews()
        }
        
    }
    

    private func stackviewSetup(eveningView: Bool, eveningView2: Bool, hostView: Bool, barView: Bool, restuarantView: Bool, msgView: Bool) {
        self.eveningView.isHidden = eveningView
        self.eveningView2.isHidden = eveningView2

        DispatchQueue.main.async {

            UIView.animate(withDuration: 0.5) {
                self.hostView.isHidden = hostView
                self.barView.isHidden = barView
                self.restuarantView.isHidden = restuarantView
                self.msgView.isHidden = msgView
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func setDate(date: Date) {
        let format = DateFormatter()
        format.dateFormat = "E dd, MMMM yyyy"
        let dateStr = format.string(from: date)
        print("date = \(dateStr)")
        self.selectedDateLbl.text = "\(dateStr)"

    }

    @IBAction func acceptInvite(_ sender: UIButton) {
        self.hideBtnAnimation(hide: true, title: "Accepted", btn: sender, view: declineView1, color: highlightGreen, bgColor: .white, width: 2)
    }
    
    @IBAction func declineInvite(_ sender: UIButton) {
        self.hideBtnAnimation(hide: true, title: "Declined", btn: sender, view: acceptView1, color: .darkGray, bgColor: .white, width: 2)
    }
    
    @IBAction func acceptInvite2(_ sender: UIButton) {
        self.hideBtnAnimation(hide: true, title: "Accepted", btn: sender, view: declineView2, color: highlightGreen, bgColor: .white, width: 2)
    }

    
    @IBAction func declineInvite2(_ sender: UIButton) {
        self.hideBtnAnimation(hide: true, title: "Declined", btn: sender, view: acceptView2, color: .darkGray, bgColor: .white, width: 2)
    }
    
    
    private func hideBtnAnimation(hide: Bool, title: String, btn: UIButton, view: UIView, color: UIColor, bgColor: UIColor, width: CGFloat) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                view.isHidden = hide
                btn.setTitle(title, for: .normal)
                btn.layer.borderWidth = width
                btn.layer.borderColor = color.cgColor
                btn.setTitleColor(color, for: .normal)
                btn.backgroundColor = bgColor
            }
        }
    }
    

    func dateManager(_ dateToGet: Date) -> [Date] {
        var dateItems = [Date]()
        
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 2 // Start on Monday (or 1 for Sunday)

        let today = calendar.startOfDay(for: dateToGet)

        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            for i in 0...6 {
                if let day = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                    dateItems.append(day)
                }
            }
        }
        
        return dateItems
    }
}


// MARK:- CollectionView for Weekly Dates

extension FirstVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weekDatesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateSetCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateSetCVCell
        cell.backgroundColor = .red
        let weekList = self.weekDatesArray[indexPath.row]
        cell.setDates(dates: weekList)
        
        for btn in cell.btnList {
            btn.addTarget(self, action: #selector(self.selectTheDate(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    @objc func selectTheDate(_ sender: UIButton) {
        print("The Tag : \(sender.tag)")
        
        self.selectedDateLbl.text = "\(sender.accessibilityHint!)"
        self.stackviewSetup(eveningView: false, eveningView2: true, hostView: true, barView: true, restuarantView: true, msgView: true)
        
        self.hideBtnAnimation(hide: false, title: "Accept", btn: self.acceptBtn1, view: declineView1, color: .white, bgColor: highlightGreen, width: 0)
        self.hideBtnAnimation(hide: false, title: "Decline", btn: self.declineBtn1, view: acceptView1, color: .darkGray, bgColor: bgGray, width: 0)
        self.hideBtnAnimation(hide: false, title: "Accept", btn: self.acceptBtn2, view: declineView2, color: .white, bgColor: highlightGreen, width: 0)
        self.hideBtnAnimation(hide: false, title: "Decline", btn: self.declineBtn2, view: acceptView2, color: .darkGray, bgColor: bgGray, width: 0)


        let date: [String : String] = ["Date" : sender.accessibilityHint!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DateSelect"), object: nil, userInfo: date)
        
        DispatchQueue.main.async {
            self.weekCollection.reloadData()
        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.weekDatesArray.count - 1 {
            print("wadwc")
            
            self.LoadTheCalendar()
            
            DispatchQueue.main.async {
                self.weekCollection.reloadData()
            }
        }
    }
 
    
}






