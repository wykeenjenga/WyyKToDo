//
//  SoundPlayer.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/18/22.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print("Can't play the audio file.")
        }
        
    }
        
}
