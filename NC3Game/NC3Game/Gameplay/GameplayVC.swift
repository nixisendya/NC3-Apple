//
//  GameplayVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class GameplayVC: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var labelStartPlayer: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var alertImage: UIImageView!
    
    @IBOutlet var overlayView: UIView!
    @IBOutlet var viewAlert: UIView!
    
    @IBOutlet weak var viewGradient: UIView!
    
    var firstPlayer: String!
    var arrayOfPlayers: [Player]!
    var indexSpy: Int!
    
    var randomLocation: String!
    
    var arrayOfSampleQuestions: [String] = [
    "Have you been to this place before?",
    "How did you get to this location?",
    "Who was the last person you spoke to in this location?",
    "If you were stuck in this place for 24 hours, what would you bring?",
    "Who's a famous person that would visit this location?",
    "If you could commit any crime here, what crime would it be?",
    "What's your favorite memory of this place?",
    "When was the last time you visited this location?",
    "Have you ever brought your date here?",
    "Do you like coming here?",
    "What type of outfit would you wear to this location?"]
    
    // Array pointer
    var i = 0
    
    var count = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Timer
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = viewGradient.bounds
        
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.3, 0.5, 1]
        
        labelStartPlayer.text = "\(firstPlayer!), start off by asking a question!"
        
        viewGradient.layer.mask = gradientMaskLayer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVote" {
            if let destinationVC = segue.destination as? VoteVC {
                destinationVC.arrayOfPlayers = arrayOfPlayers
                destinationVC.indexSpy = indexSpy
            }
        }

        if segue.identifier == "goToLocation" {
            if let destinationVC = segue.destination as? VoteLocationVC {
                destinationVC.arrayOfPlayers = arrayOfPlayers
                destinationVC.indexSpy = indexSpy
                destinationVC.randomLocation = randomLocation
            }
        }
    }
    
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    @IBAction func buttonNextSuggestionPressed(_ sender: Any) {
        // Change the label based on the selected index in array
        if i >= 0 && i < arrayOfSampleQuestions.count{
            labelQuestion.text = arrayOfSampleQuestions[i]
        }
        if i > arrayOfSampleQuestions.count-1 {
            i = i-1
        } else  {
            i = i+1
        }
    }
    
    @IBAction func buttonPreviousSuggestionPressed(_ sender: Any) {
        //Return to previous index and update label text
        if i >= 0 && i < arrayOfSampleQuestions.count-1 {
            labelQuestion.text = arrayOfSampleQuestions[i]
        }
        if i < 0 {
            i = i+1
        } else  {
           i = i-1
        }
    }
    
    @objc func update() {

        if(count >= 0){
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            timerLabel.text = minutes + ":" + seconds
            count -= 1
        } else {
            showViewTimerUp()
        }

    }
    
    func showViewTimerUp() {
        
        let imageAlert1 = UIImage(named: "Alarm1")!
        let imageAlert2 = UIImage(named: "Alarm2")!
        
        let animatedImageAlert = UIImage.animatedImage(with: [imageAlert1,imageAlert2], duration: 0.25)
        alertImage.image = animatedImageAlert
        
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.8
        view.addSubview(overlayView)
            
        viewAlert.center = self.view.center
        view.addSubview(viewAlert)
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
