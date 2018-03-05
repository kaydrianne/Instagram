//
//  HomeViewController.swift
//  Instagram
//
//  Created by TiAuna Dodd on 3/1/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var posts: [PFObject]?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 250
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }

    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        tableView.reloadData()
        retrievePhotos()
        refreshControl.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       retrievePhotos()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let postcount = posts?.count
            else{ return 0
        }
        return postcount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let postinfo = posts![indexPath.row]
        
        //code for image
        let picture = postinfo.object(forKey: "media") as? PFFile
        picture?.getDataInBackground(block: { (image: Data?, error: Error?) in
            let imageID = UIImage(data: image!)
            cell.photoImageView.image = imageID
    
        })
        //code for caption
        cell.captionLabel.text = postinfo.object(forKey: "caption") as? String
        return cell
    }
    func retrievePhotos(){
        let query = PFQuery(className: "Post")
        query.findObjectsInBackground { (post: [PFObject]?, error: Error?) in
            if(post != nil){
               self.posts = post
               self.tableView.reloadData()
            }else{
                print("Error: unable to post")
            }
        }
    }
}
