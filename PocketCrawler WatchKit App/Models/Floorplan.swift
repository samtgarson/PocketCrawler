//
//  Floorplan.swift
//  Floorplan
//
//  Created by Sam Garson on 30/07/2021.
//

import Foundation
import CoreLocation

class Floorplan: Matrix<RoomEntry> {
    static func with(size: PlanSize)-> Floorplan {
        FloorplanGenerator(size: size).generate()
    }
    
    var allRooms: [RoomEntry] {
        grid.compactMap { $0 }
    }
}
