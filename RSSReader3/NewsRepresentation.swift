//
//  NewsRepresentation.swift
//  RSSReader3
//
//  Created by Mac on 10.09.16.
//  Copyright © 2016 KanslerSoft. All rights reserved.
//

import UIKit

class NewsRepresentation: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriprionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var titleNews:String? = nil
    var image:UIImage? = nil
    var descriptionNews: String? = nil
    var pubDate:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.setTextDinamicaly(20, text: titleNews!, color: UIColor.blackColor())
        descriprionLabel.setTextDinamicaly(17, text: descriptionNews!, color: UIColor.blackColor())
        dateLabel.setTextDinamicaly(15, text: pubDate!, color: UIColor.lightGrayColor())
        imageView.image = image
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
