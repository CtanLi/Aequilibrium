//
//  CreateModel.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-11.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import Foundation

struct CreateModel: Decodable {
    let id: String
    let name: String
    let strength: Int
    let intelligence: Int
    let speed: Int
    let endurance: Int
    let rank: Int
    let courage: Int
    let firepower: Int
    let skill: Int
    let team: String
    let team_icon: String
}
