//
//  Track.swift
//  Custom URL shortener
//
//  Created by Dipanker on 03/12/17.
//  Copyright © 2017 BlackDeveloper. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSoup

class Track: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://www.google.com").responseString { res in
            print(res.result.isSuccess)
            self.html(html: res.result.value!)
        }
        

        // Do any additional setup after loading the view.
    }
    
    func html(html : String){
        
        
    }

   
    

}
