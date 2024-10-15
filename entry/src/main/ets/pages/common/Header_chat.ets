import { router } from '@kit.ArkUI'

@Component
export struct hear_chat {
  @State title: string = ''

  aboutToDisappear(): void {
    console.log(`被点击内部${this.title}`)
  }

  build() {
    Stack() {
      Row() {
        //返回主界面按钮
        Button() {
          Image($r('app.media.left_back'))
            .size({ height: 30, width: 30 })
        }.backgroundColor(Color.Transparent)
        .type(ButtonType.Circle)
        .position({ x: 10, y: 15 })
        .onClick(() => {
          console.log('退出具体聊天界面')
          router.back()
        })


        Text(this.title)
          .fontSize(26)
          .fontColor(Color.Black)


      }.height(60)
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Row({ space: 15 }) {


        //TODO 更多按钮
        Button() {
          Image($r('app.media.more'))
            .size({ height: 30, width: 30 })
            .onClick(() => {
              console.log('点击更多')
              router.pushUrl({ url: '', params: '1' })
            })
        }
        .backgroundColor(Color.Transparent)
      }.position({ x: 350, y: '15' })
    }.height(60)
    .width('100%')
    .backgroundColor('rgba(185, 185, 185, 0.5)')

  }
}