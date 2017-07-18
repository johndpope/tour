//
//  TourProgramViewController.swift
//  Tour
//
//  Created by tnt on 7/1/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit

class TourProgramViewController: UIViewController {
    @IBOutlet weak var tableViewTourProgram: UITableView!
    var tourRec:Tour!
    var listProgram:[TourProgram] = [TourProgram]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TourProgramTableViewCell", bundle: nil)
        tableViewTourProgram.register(nib, forCellReuseIdentifier: "TourProgramTableViewCell")
        listProgram = tourRec._tourProgram
    }
}

extension TourProgramViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProgram.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TourProgramTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TourProgramTableViewCell", for: indexPath) as! TourProgramTableViewCell
        cell.date.text = listProgram[indexPath.row]._day
        
        
        cell.btnShowTourProgram.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.btnClickShowWeb(_:)))
        cell.btnShowTourProgram.isUserInteractionEnabled = true
        cell.btnShowTourProgram.addGestureRecognizer(tap)
        
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func btnClickShowWeb(_ sender:UIGestureRecognizer){
        let indexPath = IndexPath(row: sender.view!.tag, section: 0)
        let cell = tableViewTourProgram.cellForRow(at: indexPath) as! TourProgramTableViewCell
        tableViewTourProgram.beginUpdates()
        cell.loadingWebView.startAnimating()
        if cell.heightWebView.constant == 0 {
            cell.heightWebView.constant = CGFloat(400)
            cell.imagebtntourprogram.image = #imageLiteral(resourceName: "ic_arrow_down")
            cell.webViewTourProgram.loadHTMLString(listProgram[indexPath.row]._content, baseURL: nil)
        }else{
            cell.heightWebView.constant = CGFloat(0)
            cell.imagebtntourprogram.image = #imageLiteral(resourceName: "ic_arrow_right")
        }
        cell.loadingWebView.stopAnimating()
        tableViewTourProgram.endUpdates()
        initlayer(v: cell.viewcontent)
    }
}
