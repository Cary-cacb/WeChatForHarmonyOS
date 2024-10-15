import { router } from '@kit.ArkUI';
import { hear } from './common/Header';
import { ChatPage } from './wechatPage'
import { friendsPage } from './friendsPage'
import { discoverPage } from './discoverPage'
import { myselfPage } from './myselfPage'
import TitleChangeUtil from './Utils/TitleChangeUtil'


@Entry
@Component
struct Index {
  @State title: string = "微信";
  @State url: string = 'pages/wechatPage'
  @State currentIndex: number = 0

  build() {
    Column() {
      hear({ title: this.title })
      Tabs({
        index: this.currentIndex,
        barPosition: BarPosition.End

      }) {
        TabContent() {
          ChatPage()
        }
        .tabBar(this.tabBarBuilder('微信', 0, $r('app.media.chat'), $r('app.media.chat_select')))

        TabContent() {
          friendsPage()
        }
        .tabBar(this.tabBarBuilder('通讯录', 1, $r('app.media.friends'), $r('app.media.friends_select')))

        TabContent() {
          discoverPage()
        }
        .tabBar(this.tabBarBuilder('发现', 2, $r('app.media.findout'), $r('app.media.findout_select')))

        TabContent() {
          myselfPage()
        }
        .tabBar(this.tabBarBuilder('我的', 3, $r('app.media.myself'), $r('app.media.myself_select')))
      }
      .barHeight(100)

      .onChange((index: number) => {
        this.currentIndex = index
        console.log(`变化${this.currentIndex}`)
        this.title = TitleChangeUtil.changeTitle(index)

        console.log(`变化${this.title}`)


      })
    }.height('100%')
    .width('100%')

  }

  @Builder
  tabBarBuilder(title: string, pageIndex: number, Img: Resource, Img_select: Resource) {
    Column() {
      Image(this.currentIndex === pageIndex ? Img_select : Img)
        .size({ width: 30, height: 30 })

      Text(title)
        .fontSize(20)
        .fontColor(this.currentIndex != pageIndex ? Color.Black : '#1afa29')
    }.width(60)
    .margin({ bottom: 20 })
    .justifyContent(FlexAlign.Start)

  }
}