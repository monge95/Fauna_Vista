//
//  MissionProgress .swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 03/10/26.
//

import SwiftUI

struct MissionProgress: View {
    
    
    var body: some View {
        VStack{
            Text("Progresso")
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                
            HStack{
                Text("Espécies registradas")
                    .font(.system(size: 12, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("%")
                    .font(.system(size: 12, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.backGround)
        .cornerRadius(10)
    }
}

#Preview {
    MissionProgress()
}
