//
//  TimerTipView.swift
//  Uni
//
//  Created by 홍유정 on 10/7/23.
//

import SwiftUI
import SDSKit

struct TimerTipView: View {

    var body: some View {
        VStack(alignment: .leading) {
            Text("타이머 활용법")
                .font(Font(SDSFont.subTitle.font))
                .foregroundStyle(Color(uiColor: .lightBlue500))
                .padding(.vertical, 12)
                .padding(.leading, 12)

            Text("추천하는 제한 시간은 5분입니다\n타이머를 설정하고 원하는 시간 동안 승부를 즐겨보세요")
                .font(Font(SDSFont.body2Long.font))
                .foregroundStyle(Color(uiColor: .gray600))
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
                .lineLimit(2)
                .lineSpacing(10.0)
        }
        .background(Color(uiColor: .gray000))
        .cornerRadius(10.0)
        .padding(.top, 32)
    }
}
