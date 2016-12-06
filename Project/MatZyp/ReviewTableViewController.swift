//
//  ReviewTableViewController.swift
//  MatZyp
//
//  Created by archane on 2016. 11. 19..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    var matzyp:Matzyp?
    var setting:Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Make button
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        if (dataCenter.user != nil) {
            
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Edit_"), style: .plain, target: self, action: #selector(ReviewTableViewController.writeButtonTapped(_rightBarButtonItem:)))
        }
    }
    //Delete button
    override func viewWillDisappear(_ animated: Bool) {
        self.parent?.navigationItem.rightBarButtonItem = nil
    }
    
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsets(top: y,left: 0,bottom: 0,right: 0)
        }
    }
    
    func Tapimage(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "detailImage") as! DetailImageViewController
        let tapLocation = sender.location(in: self.tableView)
        
        //using the tapLocation, we retrieve the corresponding indexPath
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        
        //we could even get the cell from the index, too
        let cell = self.tableView.cellForRow(at: indexPath!) as! ReviewTableViewCell
        secondViewController.image = cell.foodImage.image
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    func writeButtonTapped(_rightBarButtonItem: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "writeReview") as! UINavigationController
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewReview(review: Review) {
        self.matzyp?.reviews.append(review)
        self.matzyp?.GetRate()
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let row_count = matzyp?.reviews.count else {
            return 0
        }
        return row_count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell

        guard let review = matzyp?.reviews[indexPath.row] else {
            return cell
        }
        
        if (review.image != #imageLiteral(resourceName: "no_image_selected")) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.Tapimage(_:)))
            tap.delegate = self
            cell.foodImage.addGestureRecognizer(tap)
        }
        
        cell.userName.text = review.name
        cell.userReview.text = review.text.text
        cell.date.text = review.date.description
        cell.foodImage.image = review.image
        cell.rating.rating = review.rate

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
