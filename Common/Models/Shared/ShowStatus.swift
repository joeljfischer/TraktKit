//
//  ShowStatus.swift
//  TraktKit
//
//  Created by Joel Fischer on 7/13/22.
//  Copyright © 2022 Maximilian Litteral. All rights reserved.
//

import Foundation

public enum ShowStatus: String, Codable {
    case returningSeries = "returning series", continuing, inProduction = "in production", planned, upcoming, pilot, canceled, ended
}
