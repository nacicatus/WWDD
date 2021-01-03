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
    
    @IBOutlet weak var workflowButton: UIButton!
    
    var symp: Symptom? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    

    @IBAction func callUpWorkflow(_ sender: Any) {
        pickPath()
    }
    
    
    func configureView() {
        
        // Label
        if let symptom = symp,
            let detailDescriptionLabel = detailDescriptionLabel {
            detailDescriptionLabel.text = symptom.name
            title = symptom.system.rawValue
        }
        
        // Button
        
        
    }

    // depending on the symptom, there will be different workflows
    func pickPath() {
        switch symp?.name {
        case "Grief":
            workflowButton.titleLabel?.text = "Grief Workflow"
            // call up the workflow for Grief
        default:
            workflowButton.titleLabel?.text = "Workflow"
        }
    }
}
