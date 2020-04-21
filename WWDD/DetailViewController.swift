//
//  DetailViewController.swift
//  WWDD
//
//  Created by Yajnavalkya on 2020. 04. 21..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var symptom: Symptom? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    

    func configureView() {
        if let symptom = symptom,
            let detailDescriptionLabel = detailDescriptionLabel {
            detailDescriptionLabel.text = symptom.system.rawValue + " System Complaint"
            //title = symptom.system.rawValue
            title = symptom.name
        }
    }

}
