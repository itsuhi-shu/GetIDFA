//
//  ViewController.swift
//  GetIDFA
//
//  Created by 周 軼飛 on 2019/04/11.
//  Copyright © 2019 周 軼飛. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var label: UITextView!
    var observation: NSKeyValueObservation?
    @objc var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label.isSelectable = true
        label.isEditable = false
        label.delegate = self
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        
        view.addSubview(label)
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        label.text = appDelegate.idfaStr
        observation = observe(\.appDelegate.idfaStr, options: .new, changeHandler: { [weak self] (object, change) in
            self?.label.text =  change.newValue!
            
            self?.label.selectAll(nil)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.selectAll(nil)
    }

    @IBAction func share(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [label.text!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}


