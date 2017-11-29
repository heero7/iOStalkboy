//
//  AddEditViewController.swift
//  Talkboy
//
//  Created by Kevin Mudiandambo on 11/25/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit
import AVFoundation

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var soundNameTextField: UITextField!
    @IBOutlet weak var recordAndStopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var audioURL : URL?
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // create audio session
        let currentSession = AVAudioSession.sharedInstance()
        
        try? currentSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? currentSession.overrideOutputAudioPort(.speaker)
        try? currentSession.setActive(true)
        
        // url to save the audio
        
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let pathComponenents = [basePath, "audio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponenents) {
                // create some settings
                self.audioURL = audioURL
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey]  = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                // create the audio recorder
                
                try? audioRecorder = AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        
       enableButtons(onOff: false)
    }
    
    private func enableButtons(onOff: Bool) {
        playButton.isEnabled = onOff
        soundNameTextField.isEnabled = onOff
        saveButton.isEnabled = onOff
    }
    
    //MARK: Button functions
    @IBAction func recordSound(_ sender: Any) {
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordAndStopButton.setTitle("Record", for: .normal)
                enableButtons(onOff: true)
            } else {
                audioRecorder.record()
                recordAndStopButton.setTitle("Stop", for: .normal)
                enableButtons(onOff: false)
            }
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        if let audioURL = self.audioURL {
            audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
    }
    
    //MARK: Bar Button Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSound(_ sender: UIBarButtonItem) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let sound =  Sound(entity: Sound.entity(), insertInto: context)
            sound.name = soundNameTextField.text
            if let audioURL = self.audioURL {
                sound.audioData = try? Data(contentsOf: audioURL)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
