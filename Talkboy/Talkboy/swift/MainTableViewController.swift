//
//  MainTableViewController.swift
//  Talkboy
//
//  Created by Kevin Mudiandambo on 11/25/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit
import AVFoundation

class MainTableViewController: UITableViewController {
    
    var sounds = [Sound]()
    var audioPlayer : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sounds.count
    }
    
    private func loadItemsFromCoreData() {
         if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreData = try? context.fetch(Sound.fetchRequest()) as? [Sound] {
                if let coreDataItems = coreData {
                    sounds = coreDataItems
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItemsFromCoreData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        if let audioData = sound.audioData {
            audioPlayer = try? AVAudioPlayer(data: audioData)
            audioPlayer?.play()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
