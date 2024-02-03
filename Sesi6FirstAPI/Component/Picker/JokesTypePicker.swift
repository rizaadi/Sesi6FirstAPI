//
//  JokesTypePicker.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import SwiftUI

struct JokesTypePicker: View {
    @ObservedObject var jokesTypeVM: JokeVM
    
    var body: some View {
        Picker("Select Type", selection: $jokesTypeVM.selectedJokeType){
            ForEach(jokesTypeVM.jokesTypes) { type in
                Text(type.rawValue.capitalized)
                    .tag(type)
            }
        }
    }
}

#Preview {
    JokesTypePicker(jokesTypeVM: JokeVM())
}
