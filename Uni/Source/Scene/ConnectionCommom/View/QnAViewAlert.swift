//
//  SettingAlertView.swift
//  Uni
//
//  Created by 부창현 on 2023/10/05.
//

import SwiftUI
import SDSKit


enum ClickedButton{
    case 취소
    case 나가기
    case none
}

struct QnAViewAlert: View {
    
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
                
                Text("계정을 탈퇴하시겠어요?")
                    .font(Font(SDSFont.subTitle.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.top, 24)
                    .frame(width: 223, height: 24)
                Text("모든 기록이 사라져요")
                    .font(Font(SDSFont.body2Long.font))
                    .foregroundColor(Color(uiColor: .gray400))
                    .padding(.top, 4)
                    .frame(width: 223, height: 24)
       
           
            }.frame(width: 271, height: 96)
            
            
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
       
                Divider()
                    .frame(width: 1, height: 52)
                    .foregroundColor(Color(uiColor: .gray200))
                
                
                
                Button("탈퇴"){
                    Shown.toggle()
               
                
                }
                .frame(width: 135, height: 52, alignment: .center)
                .foregroundColor(Color(uiColor: .lightBlue600))
                .font(Font(SDSFont.subTitle.font))
                //여기 수정했음
            }
            .frame(height: 51)
            
            
        }   .frame(width: 271, height: 148)
            .background(Color.white)
            .cornerRadius(10)
            .clipped()
            .shadow(radius:3)
        //shadow x=2, blur=3/262626 10%
        
        
        
    }
    }
}



 
 struct SettingAlertView_Previews: PreviewProvider {
     static var previews: some View {
         QnAViewAlert(Shown: .constant(false), buttonClicked: .constant(.none))
     }
 }
