import { hear } from './common/Header'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct serch {
  build() {
    Column() {
      Row() {
        Row() {
          TextInput({ placeholder: '搜索' })
            .backgroundColor('#e8e8e8')
            .width(290)
          Button('取消')
            .fontSize(20)
            .fontColor('#737373')
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              router.replaceUrl({ url: 'pages/mainPage' })
            })
            .position({ x: '79%' })
        }
        .width('100%')
        .height(40)
        .borderRadius(15)

      }
      .width('100%')
      .margin({ top: 20, left: 10 })

    }.width('100%')
    .height('100%')
    .backgroundColor('rgba(185, 185, 185, 0.5)')

  }
}
