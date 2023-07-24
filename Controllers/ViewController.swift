//
//  ViewController.swift
//  PRToast
//
//  Created by Spectus Infotech on 18/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        PRToast.showToastWith(title: "Hello", descripation: "Hii", backgroundColor: .black, textColor: .white, leftSideImage: UIImage(named: "ic_heart"), rightSideImage: UIImage(named: "ic_heart"), viewOpenFrom: .Top)
    }

    
}

