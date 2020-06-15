//
//  DetectiveWinViewController.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 11/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class DetectiveWinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound(sound: "Applause", type: "mp3")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        playButtonClick()
        performSegue(withIdentifier: "unwindToHome", sender: self)
        stopSound()
    }
    @IBAction func playAgainPressed(_ sender: Any) {
        playButtonClick()
        performSegue(withIdentifier: "unwindToPlayer", sender: self)
        stopSound()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
