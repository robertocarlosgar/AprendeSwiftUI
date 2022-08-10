//
//  HistorialView.swift
//  AprendeSwiftUI
//
//  Created by alp1 on 20/7/22.
//

import SwiftUI

struct HistorialView: View {
    @State var data = Data()
    
    var body: some View {
        List{
            ForEach(data.historial, id: \.self) { result in
                //Text("\(Date(), style: .date): \(result)")
                Text("\(result)")
            }
        }.navigationBarTitle("Historial")
    }
}

struct HistorialView_Previews: PreviewProvider {
    static var previews: some View {
        HistorialView()
    }
}

