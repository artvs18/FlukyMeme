//
//  MemeInfoViewController.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 13.11.2022.
//

import UIKit

class MemeInfoViewController: UIViewController {
    
    @IBOutlet weak var memeDescriptionTW: UITextView! {
        didSet {
            memeDescriptionTW.text = memeDescription
        }
    }
    
    var memeDescription: String!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
}

