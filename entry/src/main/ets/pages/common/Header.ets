import { router } from '@kit.ArkUI'

@Component
export struct hear {
  @Link title: string

  build() {
    Stack() {
      Row() {
        // //返回登陆界面按钮
        // Button(){
        //   Image($r('app.media.left_back'))
        //     .height(40)
        // }.height(40)
        // .type(ButtonType.Circle)
        // .onClick(() => {
        //   console.log('退出登录')
        //   router.pushUrl({ url:'pages/Login' })
        // })


        Text(this.title)

          .fontSize(26)
          .fontColor(Color.Black)


      }.height(60)
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Row({ space: 15 }) {
        //搜索按钮
        Button() {
          Image($r('app.media.search'))
            .size({ height: 30, width: 30 })
            .onClick(() => {
              console.log('点击搜索')
              router.pushUrl({ url: 'pages/searchPage', params: '1' })
            })
        }
        .backgroundColor(Color.Transparent)


        //TODO 更多按钮
        Button() {
          Image($r('app.media.add'))
            .size({ height: 30, width: 30 })
            .onClick(() => {
              console.log('点击更多')
              router.pushUrl({ url: '', params: '1' })
            })
        }
        .backgroundColor(Color.Transparent)
      }.position({ x: 302, y: '15' })
    }.height(60)
    .width('100%')
    .backgroundColor('rgba(185, 185, 185, 0.5)')

  }
}