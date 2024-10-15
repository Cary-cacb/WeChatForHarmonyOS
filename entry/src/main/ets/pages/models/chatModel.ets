import { router } from '@kit.ArkUI'

@Component
export struct ChatItemStyle {
  avatar: string = ''
  name: string = ''
  message: string = ''
  time: string = ''

  build() {
    Column() {
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start }) {
        Image($r(this.avatar)).width('120px').height('120px')
          .margin({ left: '50px', right: '50px' })

        Column() {
          Text(this.name).fontSize('16fp')
          Text(this.message).fontSize('12fp').width('620px')
            .fontColor('#c3bec2')
            .maxLines(1)
        }.alignItems(HorizontalAlign.Start).flexGrow(1)

        Text(this.time).fontSize('12fp')
          .margin({ right: '50px' })
          .fontColor('#c2bec2')
      }.height('180px')
      .width('100%')

      Row() {
        Text().width('190px').height('3px')
        Divider().vertical(false)
          .color('#ededed')
          .strokeWidth('3px')
      }
      .height('3px')
      .width('100%')
    }.onClick(
      () => {
        router.pushUrl({
          url: 'pages/chatPage',
          params: { title: `${this.name}` }
        })
        console.log(`被点击   ${this.name}`)
      }
    )
  }
}