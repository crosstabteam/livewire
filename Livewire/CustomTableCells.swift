//
//  CustomTableCells.swift
//  Livewire
//
//  Created by Adil Shaikh on 18/01/16.
//  Copyright © 2016 Adil Shaikh. All rights reserved.
//

import Foundation
import UIKit

class QuotaSectionHeaderViewCell: UITableViewCell {
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class FieldSummaryHeaderViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProjectName: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class FieldSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblKey: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class QuotaFirstLevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var lblCellName: UILabel!
    @IBOutlet weak var lblCompletes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgFieldStatus: UIImageView!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblCompletesInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class TerminationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCounts: UILabel!
    @IBOutlet weak var lblVariableName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class TermHeaderTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

