//
//  GameplayVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit
import AVFoundation

class GameplayVC: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var labelStartPlayer: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var alertImage: UIImageView!
    
    @IBOutlet var overlayView: UIView!
    @IBOutlet var viewAlert: UIView!
    
    @IBOutlet weak var viewGradient: UIView!
    
    @IBOutlet weak var bubbleImage1: UIImageView!
    @IBOutlet weak var bubbleImage2: UIImageView!
    @IBOutlet weak var bubbleImage3: UIImageView!
    @IBOutlet weak var bubbleImage4: UIImageView!
    
    
    var firstPlayer: String!
    var arrayOfPlayers: [Player]!
    var indexSpy: Int!
    var audioPlayer: AVAudioPlayer?
    
    var timer: Timer?
    
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
    
    var count = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = viewGradient.bounds
        
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.3, 0.5, 1]
        
        labelStartPlayer.text = "\(firstPlayer!), start off by asking a question!"
        
        viewGradient.layer.mask = gradientMaskLayer
        
        playSoundLoop(sound: "EggTimer", type: "mp3", loop: 10)
        
        animateSpeechBubble()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVote" {
            if let destinationVC = segue.destination as? VoteVC {
                destinationVC.arrayOfPlayers = arrayOfPlayers
                destinationVC.indexSpy = indexSpy
            }
            stopSound()
            timer!.invalidate()
        }

        if segue.identifier == "goToLocation" {
            if let destinationVC = segue.destination as? VoteLocationVC {
                destinationVC.arrayOfPlayers = arrayOfPlayers
                destinationVC.indexSpy = indexSpy
                destinationVC.randomLocation = randomLocation
            }
            stopSound()
        }
    }
    
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
        stopSound()
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
            if count % 60 < 10 {
                timerLabel.text = minutes + ":0" + seconds
            }else {
               timerLabel.text = minutes + ":" + seconds
            }
            count -= 1
        } else {
            timer?.invalidate()
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
        
        playSound(sound: "AlarmSiren", type: "mp3")
    }
    
    func animateSpeechBubble() {
        bubbleImage1.alpha = 0
        bubbleImage2.alpha = 0
        bubbleImage3.alpha = 0
        bubbleImage4.alpha = 0
        
        
        UIView.animate(
            withDuration: 2,
            delay: 1,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.bubbleImage1.alpha = 1.0
                self.bubbleImage1.transform = CGAffineTransform(translationX: 0, y: -20)
            },
            completion: nil
        )
        
        UIView.animate(
            withDuration: 2,
            delay: 2,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.bubbleImage2.alpha = 1.0
                self.bubbleImage2.transform = CGAffineTransform(translationX: 0, y: -20)
            },
            completion: nil
        )
        
        UIView.animate(
            withDuration: 2,
            delay: 3,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.bubbleImage3.alpha = 1.0
                self.bubbleImage3.transform = CGAffineTransform(translationX: 0, y: -20)
            },
            completion: nil
        )
        
        UIView.animate(
            withDuration: 2,
            delay: 4,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.bubbleImage4.alpha = 1.0
                self.bubbleImage4.transform = CGAffineTransform(translationX: 0, y: -20)
            },
            completion: nil
        )
    }

}
