//
//  AddEditViewController.swift
//  Talkboy
//
//  Created by Kevin Mudiandambo on 11/25/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var soundNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button functions
    @IBAction func recordSound(_ sender: Any) {
    }
    
    @IBAction func playSound(_ sender: Any) {
    }
    
    //MARK: Bar Button Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSound(_ sender: UIBarButtonItem) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
