//
//  ViewController.swift
//  Custom URL shortener
//
//  Created by Dipanker on 17/11/17.
//  Copyright © 2017 BlackDeveloper. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class ViewController: UIViewController {

    @IBOutlet var long: UITextField!
    @IBOutlet var short: UITextField!
    @IBOutlet var shortLable: UILabel!
    @IBOutlet var copyBtn: UIButton!
    
    
    var timer = Timer()
    
    var shortString:String = ""
    var shortString2:String = "http://gourl.gq/"
    var chacker = 0
    
    @IBAction func shortClick(_ sender: Any) {
        
        if (long.text?.isEmpty==false && short.text?.isEmpty==false) {
        let longurl = long.text
        let shorturl = short.text
            
            
            
            
            if(verifyUrl(urlString: longurl)==true){
            
        
        let url = "http://gourl.gq/redirect.php"
        let range = shorturl!.index(shorturl!.startIndex, offsetBy: 16)..<shorturl!.endIndex
                
        let subUrl = shorturl![range]
        let prms: [String:String] = ["website":longurl!,"short": subUrl]
        
        Alamofire.request(url, method: .post, parameters: prms).response { (res) in
        
            if(res.response?.statusCode==200){
               self.view.makeToast("Your URL successfully created")
                self.shortLable.text = "Your Shorted Url is " + shorturl!
                
                self.shortString = shorturl!
                self.copyBtn.isHidden = false
            }
            else{
                self.view.makeToast("Something went wrong")
            }
            
        }
            
        }
            else{
                
               self.view.makeToast("Long URL IS not valid") 
                
            }
        }
        else{
            self.view.makeToast("Please Input all above the filds")
        }
        
        
        
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    @IBAction func copyUrl(_ sender: Any) {
    
        UIPasteboard.general.string =  shortString
        self.view.makeToast("CustomUrl successfully copied")
        
    }
 
    

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func shortEnd(_ sender: Any) {
        shortString2 = (short?.text)!
        if (shortString2.characters.count<=9) {
            shortString2 = "gourl.gq/"
            txt()
        }
    }
   
    @IBAction func shortTxtTapped(_ sender: Any) {
        txt()
         timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.add), userInfo: nil, repeats: true)
        
    }
    func txt(){
        self.short?.text  = shortString2
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func add(){
        if ((short.text?.characters.count)!<=8) {
            shortString2 = "gourl.gq/"
            txt()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shortLable.text = ""
        self.copyBtn.isHidden=true
        
    }
    

    


}

