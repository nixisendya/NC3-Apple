//
//  WinViewController.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 11/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {

    
    @IBOutlet weak var avatarSpyImage: UIImageView!
    @IBOutlet weak var nameSpyImage: UILabel!
    
    var realSpy: Player!
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarSpyImage.image = realSpy.avatar
        nameSpyImage.text = "\(realSpy.name) was the spy!"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToPlayer", sender: self)
    }

}
