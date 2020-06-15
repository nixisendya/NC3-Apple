//
//  PlaySound.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 11/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

func playSoundLoop(sound: String, type: String, loop: Int) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = loop
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

func stopSound(){
    audioPlayer?.stop()
}

func playButtonClick() {
    let buttonClick = URL(fileURLWithPath: Bundle.main.path(forResource: "ButtonClick", ofType: "mp3")!)
    do {
         audioPlayer = try AVAudioPlayer(contentsOf: buttonClick)
         audioPlayer?.play()
    } catch {
       print("ERROR: Could not find and play the sound file!")
    }
}
