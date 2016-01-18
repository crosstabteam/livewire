//
//  BusinessObjects.swift
//  Livewire
//
//  Created by Adil Shaikh on 19/12/15.
//  Copyright © 2015 Adil Shaikh. All rights reserved.
//

import Foundation


struct Project {
    var id: String
    var projectName: String
    var targetCompletes: String
    var qualifiedCompletes: String
}

struct FieldStatus {
    var key: String
    var value: String
}

struct TermVariable {
    var variable: String
    var elements:[String : Int]
    //var elements:Dictionary<String,Int>
}

struct QuotaCell {
    var title: String
    var target: String
    var completes: String
    var remaining: String
    var percentageAchieved: String
}

struct SubQuota {
    var subQuotaTitle: String
    var cells : [QuotaCell]
    
}

struct Quota {
    var title: String
    var subQuotas : [SubQuota]
}