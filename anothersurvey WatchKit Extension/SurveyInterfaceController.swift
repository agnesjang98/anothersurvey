//
//  SurveyInterfaceController.swift
//  anothersurvey WatchKit Extension
//
//  Created by Agnes Jang on 11/11/19.
//  Copyright © 2019 Agnes Jang. All rights reserved.
//

import Foundation
import WatchKit


class SurveyInterfaceController: WKInterfaceController {

    @IBOutlet weak var Green: WKInterfaceButton!
    @IBOutlet weak var Yellow: WKInterfaceButton!
    @IBOutlet weak var Blue: WKInterfaceButton!
    @IBOutlet weak var Red: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        Green.setBackgroundColor(.green)
        Yellow.setBackgroundColor(.yellow)
        Blue.setBackgroundColor(.blue)
        Red.setBackgroundColor(.red)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
