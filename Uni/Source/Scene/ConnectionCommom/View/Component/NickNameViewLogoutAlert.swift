//
//  CustomAlertView.swift
//  MemoFeatureTestForSparkleApp
//
//  Created by 부창현 on 2023/09/16.
//

import SwiftUI
import SDSKit



struct NickNameViewLogOutAlert: View {
    
    @Binding var Shown: Bool
    @Binding var buttonClicked: ClickedButton
    @State private var isPresented = false
    
    var body: some View {
        
        ZStack{
           Rectangle()
              .ignoresSafeArea()
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.4))
        VStack(spacing: 0){
            VStack{
                
                Text("로그아웃 하시겠습니까?")
                    .font(Font(SDSFont.subTitle.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.top, 24)
                    .frame(width: 223, height: 24)
               
         
            }.frame(width: 271, height: 72)
            
            
            Divider()
                .frame(width: 271, height: 1)
                .foregroundColor(Color(uiColor: .gray200))
            
            
            HStack(spacing: 0){
 
                
                Button("취소") {
                    Shown.toggle()
         
                }
                .frame(width: 135, height: 52, alignment: .center)
                .foregroundColor(Color(uiColor: .lightBlue600))
                .font(Font(SDSFont.body1Regular.font))
                //이거 폰트를 모르겠음
                
                
                //여기 수정했음
                Divider()
                    .frame(width: 1, height: 52)
                    .foregroundColor(Color(uiColor: .gray200))
                
                
                
                Button("로그아웃"){
                    Shown.toggle()
        
                
                }
                .frame(width: 135, height: 52, alignment: .center)
                .foregroundColor(Color(uiColor: .lightBlue600))
                .font(Font(SDSFont.subTitle.font))
                //여기 수정했음
            }
            .frame(height: 51)
            
            
        }   .frame(width: 271, height: 124)
            .background(Color.white)
            .cornerRadius(10)
            .clipped()
            .shadow(radius:3)

        
        
        
    }
    }
}

struct LogOutAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameViewLogOutAlert(Shown: .constant(false), buttonClicked: .constant(.none))
    }
}
