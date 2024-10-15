import { hear_chat } from './common/Header_chat'
import { router } from '@kit.ArkUI'
import MMKVUtil from './Utils/MMKVDBUtil'
import ChatUtil from './Utils/SQLite_chat'
import { Chat } from './entity/Friend'
import { chatInfo } from './entity/chatInfo'

class routerParams {
  title: string

  constructor(title: string) {
    this.title = title
  }
}

@Entry
@Component
struct chatPage {
  aboutToAppear(): void {
    let chat: Chat = ChatUtil.getChat(this.title)
    this.avatar = chat.avatar
    // let date: Date = new Date()
    // let old_date: Date = new Date('2024/7/21')
    // console.log('日期' + (date.getDate() - old_date.getDate()))
    /* TODO 从数据库中提取出跟这个人的对话信息，用一个字符串数组接收
    TODO 然后用JSON.parse()把里面的东西都转成对话记录对象，再用对话记录类数组接收*/
    let jsString = MMKVUtil.get_class_set(this.title)
    let msgArr: chatInfo[] = []
    jsString.forEach(val => {
      let e: chatInfo = JSON.parse(val)
      console.log(`mmkv 接收到的数据 ${e}`)
      msgArr.push(e)
    });
    this.msgArr = msgArr
  }

  aboutToDisappear(): void {
    //TODO 在界面关掉之前要把这里的对象数组里的每一个数据JSON.stringify()处理成字符串
    //TODO            字符串全扔到一个字符串数组里面去，
    //TODO           把字符串数组再存到数据库里面去
    let msgArr: chatInfo[] = this.msgArr
    let msgStrArr: string[] = []
    msgArr.forEach(val => {
      msgStrArr.push(JSON.stringify(val))
      console.log(`mmkv 传出的数据${val.msg}`)
    });
    MMKVUtil.newKV_class_set(this.title, msgStrArr)
  }

  @State messageIn: string = ''
  @State messageGet: string = ''
  @State title: string = (router.getParams() as routerParams).title
  @State inputImage: string = 'app.media.keyboard'
  @State inputText: string = ''
  @State heiG: number = 60
  @State curLine: number = 0;
  @State lineNumb: number = 0;
  @State inputWidth: number = 225;
  @State avatar: string = ''
  @State msgArr: chatInfo[] = []
  @State textInput: string = ''

  build() {
    // Column() {
    //
    //   hear_chat({ title: this.title })
    //   TextInput({ placeholder: '输入聊天信息' })
    //     .fontSize(60)
    //     .fontColor(Color.Gray)
    //     .onChange((value: string) => {
    //       this.message_in = value
    //     })
    //   Row() {
    //     Button('存储信息')
    //       .onClick(() => {
    //         MMKVUtil.newKV_string('test_1', this.message_in)
    //       })
    //     Button('获取信息')
    //       .onClick(() => {
    //         this.message_get = MMKVUtil.get_string('test_1')
    //       })
    //     Button('删除信息')
    //       .onClick(() => {
    //         MMKVUtil.delete_key('test_1')
    //       })
    //   }
    //
    //
    //   Text(this.message_get)
    //     .fontSize(60)
    //     .fontColor(Color.Black)
    // }
    Column() {
      hear_chat({ title: this.title })

      // Image($r(this.avatar))
      //   .size({ width: 100, height: 100 })
      Stack() {
        List() {
          ForEach(this.msgArr, (msg: chatInfo) => {
            ListItem() {
              Row({ space: 10 }) {
                Text(msg.msg)
                  .fontSize(20)
                  .backgroundColor('#24d132')
                  .borderRadius(10)
                Image($r(this.avatar))
                  .size({ width: 40, height: 40 })
                  .borderRadius(4)
              }.justifyContent(FlexAlign.End)
              .margin({ bottom: 10, right: 20 })
              .width('98.9%')
            }
          })
        }

        Row({ space: 10 }) {
          Button() {
            Image($r(this.inputImage))
              .height(40)
              .onClick(() => {
                if (this.inputImage == 'app.media.keyboard') {
                  this.inputImage = 'app.media.mike'
                  this.inputText = ''
                } else {
                  this.inputImage = 'app.media.keyboard'
                  this.inputText = '按住说话'
                }
              })
          }
          .margin({ left: 10 })
          .backgroundColor(Color.Transparent)

          TextArea({ placeholder: this.inputText })
            .width(this.inputWidth)
            .backgroundColor(Color.White)
            .wordBreak(WordBreak.BREAK_ALL)
            .onContentScroll((x, y) => {
              if (y - this.curLine > 0) {
                this.heiG -= 60
                this.curLine = y
                this.lineNumb--
              } else if (y - this.curLine < 0) {
                this.heiG += 60
                this.heiG = y
                this.lineNumb++
              }
            })
            .onChange((val: string) => {
              this.textInput = val
              if (val.length > 0) {
                this.inputWidth = 200


              }

              if (val.length == 0) {
                this.inputWidth = 225
              }
            })
          Button() {
            Image($r('app.media.emo'))
              .height(40)

              .onClick(() => {
              })
          }.backgroundColor(Color.Transparent)

          if (this.inputWidth == 200) {
            /*TODO
             onClick
             判断一下对话记录数组内容是否已经到达50条，如果已经到达50条就删掉第一条
             然后将这条对话记录加到对话信息数组里面去
             */
            Button('发送')
              .type(ButtonType.Capsule)
              .backgroundColor('#24d132')
              .onClick(() => {
                if (this.textInput.length > 0) {
                  let e = new chatInfo(0, this.textInput, new Date())
                  console.log(`mmkv 发送的数据是 ${e.msg}`)
                  this.msgArr.push(e)
                  this.inputText = ''
                }
              })
          } else {
            Button() {
              Image($r('app.media.add'))
                .height(40)


            }.backgroundColor(Color.Transparent)
          }

        }
        .height(this.heiG + 5 * this.lineNumb)
        .width('100%')
        .padding({ bottom: 10, top: 5 })
        .alignItems(VerticalAlign.Bottom)
        .backgroundColor('rgba(185, 185, 185, 0.5)')
        .position({ bottom: 0 })
      }
    }.justifyContent(FlexAlign.SpaceBetween)
    .height('100%')
  }
}