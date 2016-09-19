//
//  VenueTableViewController.swift
//  trySwift
//
//  Created by Natasha Murashev on 8/13/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import UIKit

class VenueTableViewController: UITableViewController {

    var venue: Venue!
    
    fileprivate enum VenueDetail: Int {
        case header, wifi, address, map, twitter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Venue"
        configureTableView()
    }
}

// MARK: - Table view data source
extension VenueTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch VenueDetail(rawValue: (indexPath as NSIndexPath).row)! {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VenueHeaderTableViewCell), for: indexPath) as! VenueHeaderTableViewCell
            cell.configure(withVenue: venue)
            return cell
        case .wifi:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WifiInfoTableViewCell), for: indexPath) as! WifiInfoTableViewCell
            cell.configure(withWifiInfo: venue.wifiInfo)
            return cell
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextTableViewCell), for: indexPath) as! TextTableViewCell
            cell.configure(withAttributedText: venue.formattedAddress)
            return cell
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MapTableViewCell), for: indexPath) as! MapTableViewCell
            cell.configure(withAddress: venue.address)
            return cell
        case .twitter:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TwitterFollowTableViewCell), for: indexPath) as! TwitterFollowTableViewCell
            cell.configure(withUsername: venue.twitter, delegate: self)
            return cell

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case VenueDetail.map = VenueDetail(rawValue: (indexPath as NSIndexPath).row)! {
            return 300
        }
        
        return UITableViewAutomaticDimension
    }
}

private extension VenueTableViewController {
    
    func configureTableView() {
        tableView.register(UINib(nibName: String(describing: VenueHeaderTableViewCell), bundle: nil), forCellReuseIdentifier: String(describing: VenueHeaderTableViewCell))
        tableView.register(UINib(nibName: String(describing: WifiInfoTableViewCell), bundle: nil), forCellReuseIdentifier: String(describing: WifiInfoTableViewCell))
        tableView.register(UINib(nibName: String(describing: TextTableViewCell), bundle: nil), forCellReuseIdentifier: String(describing: TextTableViewCell))
        tableView.register(UINib(nibName: String(describing: MapTableViewCell), bundle: nil), forCellReuseIdentifier: String(describing: MapTableViewCell))
        tableView.register(UINib(nibName: String(describing: TwitterFollowTableViewCell), bundle: nil), forCellReuseIdentifier: String(describing: TwitterFollowTableViewCell))
        
        tableView.estimatedRowHeight = 83
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
}
