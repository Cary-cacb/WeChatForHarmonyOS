import router from '@ohos.router'
import { it } from '@ohos/hypium'
import { hear } from './common/Header'
import { Chat } from './entity/Friend'
import { ChatItemStyle } from './models/chatModel'
import ChatUtil from './Utils/SQLite_chat'

@Entry
@Component
export struct ChatPage {
  private chats: Chat[] = ChatUtil.getAllChat()

  build() {
    Column() {


      List() {
        ForEach(this.chats, (item: Chat) => {
          ListItem() {
            ChatItemStyle({
              avatar: item.avatar,
              name: item.name,
              message: item.message,
              time: item.time
            })

          }
        })
      }

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#eeeeee')

  }
}