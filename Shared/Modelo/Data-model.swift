import Foundation
import RealmSwift

/// Data Model to make Swift understand the Realm Database.
class IataIcaoCodes: Object {
    
    /// Name of the Airport.
    @objc dynamic var ﻿Name: String? = nil
    
    /// Name of the City.
    @objc dynamic var City: String? = nil
    
    /// Country of the Airport.
    @objc dynamic var Country: String? = nil
    
    /// `IATA` code of the Airport.
    @objc dynamic var IATA: String? = nil
    
    /// `ICAO` code if the Airport.
    @objc dynamic var ICAO: String? = nil
}

