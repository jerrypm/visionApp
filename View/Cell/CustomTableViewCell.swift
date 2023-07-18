//
//  CustomTableViewCell.swift
//  TestATASKApp
//
//  Created by Jeri Purnama on 20/06/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var inputText: UILabel!
    @IBOutlet weak var resultText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
}
