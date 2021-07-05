//
//  TRDatumView.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import SwiftUI

struct TRDatumView: View {
    var datum: Datum
        
    var body: some View {
        VStack {
            Text(datum.title)
                .font(.title)
            HStack {
                Text(datum.author.name)
                Text("/")
                Text(datum.date.formattedFromTimestamp)
            }
        }
    }
}

//struct TRDatumView_Previews: PreviewProvider {
//    static var previews: some View {
//        TRDatumView()
//    }
//}
