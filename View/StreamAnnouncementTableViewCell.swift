//
//  StreamAnnouncementTableViewCell.swift
//  StockbitUI
//
//  Created by erric alfajri on 29/03/18.
//  Copyright © 2018 STOCKBIT. All rights reserved.
//

import UIKit

public class StreamAnnouncementTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    public func setReksadanaContentAttachment(reksadana: String, isLastContent: Bool = false) {
        titleLabel.text = reksadana
        separatorView.isHidden = isLastContent
    }
    
    public func setReportContentAttachment(announcement: String, isLastContent: Bool = false) {
        
    }
}
