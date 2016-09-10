//
//  Feed.swift
//  RSSReader3
//
//  Created by Mac on 08.09.16.
//  Copyright © 2016 KanslerSoft. All rights reserved.
//

import UIKit
import CoreData


class Feed: UITableViewController , NSXMLParserDelegate{
    var isItem = false
    var isTitle = false
    var isDescription = false
    var isPubDate = false
    
    var titleNews = ""
    var descriptionNews = ""
    var image = ""
    var pubDate = ""
    weak var activityIndicatorView: UIActivityIndicatorView!
    var news:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndikator()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        let url = NSURL(string: "http://news.liga.net/all/rss.xml")
        let xmlParser = NSXMLParser(contentsOfURL: url!)
        xmlParser!.delegate = self
        dispatch_async(dispatch_get_main_queue(), {
             xmlParser!.parse()
            self.news = News.MR_findAll()!
             self.activityIndicatorView.stopAnimating()
        })
       
        
        
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
       
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView!.reloadData()
        })
        
        
    }
    func parserDidStartDocument(parser: NSXMLParser) {
        
        
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "item"{
            isItem = true
        }
        if isItem{
            if elementName == "title"{
                isTitle = true
            }else{
                if elementName == "description"{
                    isDescription = true
                }else{
                    if elementName == "enclosure"{
                        image = attributeDict["url"]!
                    }else{
                        if elementName == "pubDate"{
                            isPubDate = true
                        }
                    }
                }
            }
        }
        
        //  print("\(elementName) : \(attributeDict) : \(qName)")
        
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if isTitle{
            titleNews = string
            isTitle = false
        }else{
            if isDescription{
                descriptionNews = string
                isDescription = false
            }else{
                if isPubDate{
                    pubDate = string
                    persistNews(titleNews, descriptionNews: descriptionNews, imageURL: image, pubDate: pubDate)
                    clearTemp()
                    isPubDate = false
                    isItem = false
                    
                  
                }
            }
        }
        //  print(string)
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func clearTemp(){
        titleNews = ""
        descriptionNews = ""
        image = ""
        pubDate = ""
    }
    
    func persistNews(titleNews: String, descriptionNews: String, imageURL: String,pubDate: String ) {
        
        let localContext = NSManagedObjectContext.MR_contextForCurrentThread()
        
        let predicate = NSPredicate(format: "title ==[c] %@ AND descriptionNews ==[c] %@", titleNews, descriptionNews)
        
        let newsFounded = News.MR_findFirstWithPredicate(predicate, inContext: localContext)
        //print(newsFounded?.descriptionNews)
        //TODO
        if newsFounded == nil{
            
            let news = News.MR_createEntityInContext(localContext)
            news?.title = titleNews
            news?.descriptionNews = descriptionNews
            let url = NSURL(string: imageURL)
            let imageData = NSData(contentsOfURL: url!)
            news?.image = imageData
            news?.pubDate = pubDate
            
     
            localContext.MR_saveToPersistentStoreAndWait()
        }
    }
    func activityIndikator(){
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.tableView!.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
        
    }
    
    
  
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return news.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewsCell
        let cellNews = news[indexPath.row] as! News
        
        
        cell.imageNews?.image = UIImage(data: cellNews.image!)
        
        cell.titleNews.setTextDinamicaly(17.0, text: cellNews.title!,color: UIColor.blackColor())
        cell.descriptionNews.setTextDinamicaly(13.0, text: cellNews.descriptionNews!,color: UIColor.blackColor())
        cell.pubDate.setTextDinamicaly(17.0, text: cellNews.pubDate!, color: UIColor.lightGrayColor())
        
        
        return cell
    }
    
 
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "push"){
           let newsController = segue.destinationViewController as! NewsRepresentation
            let indexPath = self.tableView!.indexPathForSelectedRow
            
            let cellNews = news[indexPath!.row] as! News
            newsController.titleNews = cellNews.title!
            newsController.descriptionNews = cellNews.descriptionNews!
            newsController.image = UIImage(data: cellNews.image!)
            newsController.pubDate = cellNews.pubDate!
            
        }
    }
    

}
