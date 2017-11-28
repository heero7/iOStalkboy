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
    
    var audioRecorder : AVAudioRecorder?
    

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
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey]  = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                // create the audio recorder
                
                try? audioRecorder = AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        
        
        
    }
    
    //MARK: Button functions
    @IBAction func recordSound(_ sender: Any) {
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                recordAndStopButton.setTitle("Stop", for: .normal)
                audioRecorder.stop()
            } else {
                recordAndStopButton.setTitle("Record", for: .normal)
                audioRecorder.record()
            }
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
    }
    
    //MARK: Bar Button Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSound(_ sender: UIBarButtonItem) {
        
    }
}
