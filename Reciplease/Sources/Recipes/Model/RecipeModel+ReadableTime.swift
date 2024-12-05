//
//  RecipeModel+ReadableTime.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import Foundation

extension RecipeModel {
    var readableTime: String {

        guard time > 0 else { return "-"}

        let totalSeconds = time * 60

        let result = (totalSeconds / 3600, (totalSeconds % 3600) / 60) // Hours, Minutes.

        let hours = result.0 == 0 ? "" : String(result.0) + "h"

        let minutes = result.1 == 0 ? "" : String(result.1) + "m"

        return hours + minutes
    }
}
