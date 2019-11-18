//
//  HomeVC_1.swift
//  BostonByte_Test
//
//  Created by Apple on 16/11/19.
//  Copyright © 2019 Ajay Ranekar. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var movieDataArray = [[String: Any]]()
    var isLeftAlign = true
    var isAscending = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieDataArray =
            [
                [
                    "title" : "Fatteshikast",
                    "details" : "Set during the reign of Chhatrapati Shivaji Maharaj, the film depicts the Maratha leader`s fight against the Mughal army. This historical drama portrays the grand battle between the two armies over the city of Pune.",
                    "image" : #imageLiteral(resourceName: "ford_ferrari")
                ],
                [
                    "title" : "Bala",
                    "details" : "The film tells the story of Bala (Ayushmann Khurana) a man who is balding prematurely and how he copes with the situation.",
                    "image" : #imageLiteral(resourceName: "bala")
                ],
                [
                    "title" : "Ford v Ferrari",
                    "details" : "Academy Award-winners Matt Damon and Christian Bale star in FORD v FERRARI, based on the remarkable true story of the visionary American car designer Carroll Shelby (Damon) and the fearless British-born driver Ken Miles (Bale).",
                    "image" : #imageLiteral(resourceName: "fatteshikast")
                ],
                [
                    "title" : "Joker",
                    "details" : "Arthur Fleck, a man struggling with loneliness and isolation, wears two masks.",
                    "image" : #imageLiteral(resourceName: "joker")
                ],
                [
                    "title" : "Housefull 4",
                    "details" : "When 6 lovers are parted because of conspiracy and revenge in the year 1419, the characters cross paths again in 2019.",
                    "image" : #imageLiteral(resourceName: "housefull")
                ]
        ]
        
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Boston Byte"
        sortData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    
    //    MARK:- Initialize View Method
    fileprivate func initViews() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNavigationButtonAction(_:)))
        
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        
        tableView.register(UINib.init(nibName: "LeftAlignTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftAlignTableViewCell")
        tableView.register(UINib.init(nibName: "RightAlignTableViewCell", bundle: nil), forCellReuseIdentifier: "RightAlignTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
 
    }
    
    //    MARK:- Add Button Action
    @objc private func addNavigationButtonAction(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.vcType = "add"
        vc.completionHandler = { movieData in
            self.movieDataArray.append(movieData)
            self.tableView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    MARK:- Bottom View Button Action Methods
    @IBAction func homeButtonAction(_ sender: UIButton) {
        isLeftAlign = !isLeftAlign
        tableView.reloadData()
    }
    
    @IBAction func settingButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    MARK:- Methods
    fileprivate func sortData() {
        isLeftAlign = UserDefaults.standard.bool(forKey: Constant.IS_LEFT_ALIGN)
        isAscending = UserDefaults.standard.bool(forKey: Constant.IS_ASCENDING)
         
        movieDataArray.sort { (data1, data2) -> Bool in
            let title1 = data1["title"] as? String ?? ""
            let title2 = data2["title"] as? String ?? ""
            if isAscending {
                if title1.localizedCompare(title2) == .orderedAscending {
                    return true
                }
            } else {
                if title1.localizedCompare(title2) == .orderedDescending {
                    return true
                }
            }
            return false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK:- TableView DataSource and Delegate Methods
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movieDataArray[indexPath.row]
        
        if isLeftAlign {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftAlignTableViewCell", for: indexPath) as! LeftAlignTableViewCell
            
            cell.titleLabel.text = movie["title"] as? String
            cell.descriptionLabel.text = movie["details"] as? String
            cell.myImageView.image = movie["image"] as? UIImage
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightAlignTableViewCell", for: indexPath) as! RightAlignTableViewCell
            
            cell.titleLabel.text = movie["title"] as? String
            cell.descriptionLabel.text = movie["details"] as? String
            cell.myImageView.image = movie["image"] as? UIImage

            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieDataArray[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.data = movie
        vc.vcType = "details"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
