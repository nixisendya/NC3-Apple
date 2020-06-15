//
//  EndGameVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class EndGameVC: UIViewController {

    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerAvatar: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var firstLabelGuess: UILabel!
    
    @IBOutlet weak var magnifyingGlassImage: UIImageView!
    
    @IBOutlet weak var footStep1: UIImageView!
    @IBOutlet weak var footStep2: UIImageView!
    @IBOutlet weak var footStep3: UIImageView!
    @IBOutlet weak var footStep4: UIImageView!
    
    var performSegueToWinLoseCondition = false
    var votedPlayer: Player?
    var chosenLocation = ""
    var realSpy: Player!
    var randomLocation: String!
    var realLocation: String!
    
    var firstLabel: String!
    var secondLabel: String!
    var thirdImage: String!

    var seconds = 3
    
    var isSpy: Bool!
    var spyGuessCorrect: Bool!
    
    var spyOrLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        firstLabelGuess.text = firstLabel
        playerNameLabel.text = secondLabel
        playerAvatar.image = UIImage(named: thirdImage)

        if (votedPlayer != nil){
            spyOrLocation = "Spy"
            isSpy = votedPlayer!.isSpy
        } else {
            isSpy = false
        }
        
        if (realLocation != nil){
            spyOrLocation = "Location"
            if realLocation == secondLabel {
                spyGuessCorrect = true
            } else {
                spyGuessCorrect = false
            }
        } else {
            spyGuessCorrect = false
        }
        
        animateGlass()
        animateFootSteps()

      
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            playSound(sound: "EggTimer", type: "mp3")
            self.seconds -= 1
            if self.seconds == 0 {
                print("Go!")
                self.determineWinLose()
                timer.invalidate()
            } else {
                self.timerLabel.text = "\(self.seconds)"
            }
            stopSound()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLose" {
            if let destinationVC = segue.destination as? WinViewController {
                destinationVC.realSpy = realSpy
            }
        }
    }

    func animateGlass() {
        let point = CGPoint(x: 280, y: 550)
        let circlePath = UIBezierPath(arcCenter: point, radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = 1.5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath

        magnifyingGlassImage.layer.add(animation, forKey: nil)

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(circleLayer)
    }
    
    func determineWinLose() {
        if (spyOrLocation == "Spy") {
            if (isSpy) {
                print("Detective Menang")
                performSegue(withIdentifier: "goToDetectiveWin", sender: self)
            } else {
                print("Spy menang")
                performSegue(withIdentifier: "goToLose", sender: self)
            }
        } else {
            if (!spyGuessCorrect) {
                print("Detective Menang")
                performSegue(withIdentifier: "goToDetectiveWin", sender: self)
            } else {
                print("Spy menang")
                performSegue(withIdentifier: "goToLose", sender: self)
            }
        }
    }
    
    func animateFootSteps() {
        footStep1.transform = CGAffineTransform(rotationAngle: (-60).degreesToRadians)
        footStep1.alpha = 0
        footStep2.transform = CGAffineTransform(rotationAngle: (-30).degreesToRadians)
        footStep2.alpha = 0
        footStep3.transform = CGAffineTransform(rotationAngle: (-60).degreesToRadians)
        footStep3.alpha = 0
        footStep4.alpha = 0
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.footStep1.alpha = 0.2
            },
            completion: nil
        )
        
        UIView.animate(
            withDuration: 1,
            delay: 0.5,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.footStep2.alpha = 0.4
            },
            completion: nil
        )
        
        UIView.animate(
            withDuration: 1,
            delay: 1,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.footStep3.alpha = 0.6
            },
            completion: nil
        )
        
        UIView.animate(
            withDuration: 1,
            delay: 1.5,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.footStep4.alpha = 1
            },
            completion: nil
        )
    }
}

extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}
