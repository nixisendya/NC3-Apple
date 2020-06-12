//
//  ViewController.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if Core.share.isNewUser(){
            let storyBoard = UIStoryboard(name: "HowToPlay", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "onBoarding") as! HowToPlayVC
            self.navigationController?.pushViewController(vc, animated: true)
           
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }


}

class Core {
    static let share = Core ()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

