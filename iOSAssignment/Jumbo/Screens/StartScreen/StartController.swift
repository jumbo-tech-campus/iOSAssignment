//
//  StartController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/19/23.
//

import UIKit
import Kingfisher

class StartScreen: UIViewController {
    @IBOutlet weak var startImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        guard let url = Bundle.main.url(forResource: "jumbo", withExtension: "gif") else { return }
        startImageView.kf.setImage(with: url)
      }
}
