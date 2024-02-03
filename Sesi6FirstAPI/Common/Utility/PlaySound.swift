//
//  PlaySound.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import Foundation
import AVFoundation
import UIKit

func playSound(soundName: String) {
    guard let soundFile = NSDataAsset(name: soundName) else {
        print("Cannot read file name \(soundName)")
        return
    }
    
    do {
        audioPlayer = try AVAudioPlayer(data: soundFile.data)
        audioPlayer?.play()
    } catch {
        print("Error : \(error.localizedDescription) creating audioPlayer")
    }
}
