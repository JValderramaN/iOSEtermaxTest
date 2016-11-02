//
//  HomeViewController.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    var canStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveDataIntoRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Animations
    
    func startButtonAnimation1(){
        self.startButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 2, animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (finish) in
            self.startButtonAnimation2()
        }
    }
    
    func startButtonAnimation2(){
        UIView.animate(withDuration: 2, delay: 0, options: .allowUserInteraction, animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finish) in
            UIView.animate(withDuration: 2, delay: 0, options: .allowUserInteraction, animations: {
                self.startButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { finish in
                self.startButtonAnimation2()
            }
        }
    }
    
    // MARK: - Start Section
    
    func saveDataIntoRealm(){
        let internetConnetion = NetworkKit.isConnectedToNetwork()
        if !internetConnetion{
            var message : String = ""
            var title : String = ""
            
            let realm = try! Realm()
            let entries = realm.objects(RedditEntry.self)
            
            if entries.count > 0{
                title = "Warning"
                message = "The Internet connection appears to be offline. Last connection data will be used."
                self.canStart = true
            }else{
                self.canStart = false
                title = "Error"
                message = "You need internet connection to get started with this application."
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            NetworkKit.fetchData(type: RedditEntry.self, success: {
                self.startButton.backgroundColor = Color.blueColor
                self.startButtonAnimation2()
                self.canStart = true
            }) { (error) in
                print("error \(error.localizedDescription)")
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                }
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
            print("Realm path \(Realm.Configuration.defaultConfiguration.fileURL!)")
        }
    }
    
    func start(){
        self.navigationController?.pushViewController(Controllers.instantiateEntriesTableViewController(), animated: true)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if canStart{
            start()
        }else{
            saveDataIntoRealm()
        }
    }
}
