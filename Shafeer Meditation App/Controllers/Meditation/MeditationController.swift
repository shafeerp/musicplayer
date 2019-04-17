//
//  ViewController.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 14/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class MeditationController: UIViewController {
    @IBOutlet weak var meditationTable: UITableView!
    var documentId = String()
    var meditationData = [Meditation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    func initializeUI() {
        meditationTable.separatorColor = UIColor.clear
        meditationTable.tableFooterView = UIView()
        FirebaseManager.Database.getMeditions { (meditation) in
            self.meditationData = meditation!
            self.meditationTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.MUSIC_VIEW {
            let vc = segue.destination as! MusicController
            vc.documentId = self.documentId
            
        }
    }

    @IBAction func handleLogout(_ sender: Any) {
        Defaults.setIsLogin(false)
        Defaults.clearLogin()
        self.dismiss(animated: true, completion: nil)
    }
}

extension MeditationController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meditationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.MEDITATION_CELL, for: indexPath) as! MeditationCell
        cell.meditationImg.kf.setImage(with: URL(string: meditationData[indexPath.row].image))
        cell.name.text = meditationData[indexPath.row].name
        cell.viewCount.text = meditationData[indexPath.row].doingRightNow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.documentId = meditationData[indexPath.row].documentId
        performSegue(withIdentifier: Constants.Segue.MUSIC_VIEW, sender: self)
    }
    
    
    
    
}
