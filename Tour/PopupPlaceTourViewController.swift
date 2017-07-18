//
//  PopupPlaceTourViewController.swift
//  Tour
//
//  Created by tnt on 7/7/17.
//  Copyright © 2017 thangvnnc. All rights reserved.
//

import UIKit
class PopupPlaceTourViewController: UIViewController {

    @IBOutlet weak var placeTourTableView: UITableView!
    var listPlace:[Place] = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        placeTourTableView.register(nib, forCellReuseIdentifier: "PlaceTableViewCell")
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        showAnimate()
        print(listPlace.count)
    }

    @IBAction func closePopup(_ sender: UIButton) {
        removeAnimate()
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: { 
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { (finished:Bool) in
            if finished {
                self.view.removeFromSuperview()
            }
        })
        
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != placeTourTableView {
            removeAnimate()
        }
    }
}

extension PopupPlaceTourViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlace.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        let imagetour:[String] = listPlace[indexPath.row]._listimages
        cell.slideShow.auk.removeAll()
        for i in imagetour {
            cell.slideShow.auk.show(url: i)
            cell.slideShow.auk.settings.contentMode = .scaleToFill
        }
        cell.slideShow.auk.startAutoScroll(delaySeconds: 4)
        cell.phone.text = listPlace[indexPath.row]._phone
        cell.address.text = listPlace[indexPath.row]._address
        cell.nameplace.text = listPlace[indexPath.row]._nameplace
        cell.time.text = listPlace[indexPath.row]._activitytime
        cell.price.text = listPlace[indexPath.row]._price
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
