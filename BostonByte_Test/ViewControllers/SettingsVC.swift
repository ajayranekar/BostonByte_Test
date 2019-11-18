//
//  SettingsVC.swift
//  BostonByte_Test
//
//  Created by Apple on 16/11/19.
//  Copyright © 2019 Ajay Ranekar. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var myContainerView: UIView!
    @IBOutlet weak var leftAlignImageView: UIImageView!
    @IBOutlet weak var rightAlignImageView: UIImageView!
    @IBOutlet weak var ascendingImageView: UIImageView!
    @IBOutlet weak var descendingImageView: UIImageView!
    
    var isLeftAlign: Bool?
    var isAscending: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
    }
    
    //    MARK:- Initialize View Method
    fileprivate func initViews() {
    
        self.title = "Settings"
    
        myContainerView.layer.cornerRadius = 4
        
        isLeftAlign = UserDefaults.standard.bool(forKey: Constant.IS_LEFT_ALIGN)
        isAscending = UserDefaults.standard.bool(forKey: Constant.IS_ASCENDING)
        
        if isLeftAlign ?? true {
            // left align
            leftAlignImageView.image = UIImage.init(named: "checked")
            rightAlignImageView.image = UIImage.init(named: "unchecked")
        } else {
            // right align
            leftAlignImageView.image = UIImage.init(named: "unchecked")
            rightAlignImageView.image = UIImage.init(named: "checked")
        }
        
        if isAscending ?? true {
            // ascending
            ascendingImageView.image = UIImage.init(named: "checked")
            descendingImageView.image = UIImage.init(named: "unchecked")
        } else {
            // descending
            ascendingImageView.image = UIImage.init(named: "unchecked")
            descendingImageView.image = UIImage.init(named: "checked")
        }
        
    }
    
    @IBAction func alignmentButtonAtion(_ sender: UIButton) {
        if sender.tag == 1 {
            // left align button clicked
            isLeftAlign = true
            leftAlignImageView.image = UIImage.init(named: "checked")
            rightAlignImageView.image = UIImage.init(named: "unchecked")
            UserDefaults.standard.set(true, forKey: Constant.IS_LEFT_ALIGN)
            UserDefaults.standard.synchronize()
        } else if sender.tag == 2 {
            // right align button clicked
            isLeftAlign = false
            leftAlignImageView.image = UIImage.init(named: "unchecked")
            rightAlignImageView.image = UIImage.init(named: "checked")
            UserDefaults.standard.set(false, forKey: Constant.IS_LEFT_ALIGN)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    @IBAction func sortButtonAtion(_ sender: UIButton) {
        if sender.tag == 1 {
            // ascending button clicked
            isAscending = true
            ascendingImageView.image = UIImage.init(named: "checked")
            descendingImageView.image = UIImage.init(named: "unchecked")
            UserDefaults.standard.set(true, forKey: Constant.IS_ASCENDING)
            UserDefaults.standard.synchronize()
        } else if sender.tag == 2 {
            // descending button clicked
            isAscending = false
            ascendingImageView.image = UIImage.init(named: "unchecked")
            descendingImageView.image = UIImage.init(named: "checked")
            UserDefaults.standard.set(false, forKey: Constant.IS_ASCENDING)
            UserDefaults.standard.synchronize()
        }
    }
    
}
