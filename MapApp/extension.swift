//
//  extension.swift
//  MapApp
//
//  Created by Tchang on 21/06/16.
//  Copyright © 2016 Tchang. All rights reserved.
//

import UIKit

extension String
{
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
