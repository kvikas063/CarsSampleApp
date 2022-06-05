//
//  AppConstant.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import Foundation
import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let OFFLINE_DATA_KEY = "OFFLINE_DATA"

let DATE_FORMAT = "dd.MM.yyyy HH:mm"
let DATETIME_FORMAT = "d MMMM, HH:mm"
let DATEYEAR_FORMAT = "d MMMM yyyy, HH:mm"

struct API_ENDPOINT {
    static let carListPath = "article/get_articles_list"
}

struct ScreenSize {
    static let SCREEN_WIDTH   = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT  = UIScreen.main.bounds.size.height
}
