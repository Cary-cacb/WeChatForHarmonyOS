import { router } from '@kit.ArkUI'
import { hear } from './common/Header'
import { reminderAgentManager } from '@kit.BackgroundTasksKit'
import { BusinessError } from '@kit.BasicServicesKit'
import commonEventManager from '@ohos.commonEventManager';
import { ValuesBucket } from '@kit.ArkData';
import ChatUtil from './Utils/SQLite_chat'


@Entry
@Component
export struct myselfPage {
  @State msg: string = '111'

  aboutToAppear(): void {
    let list: ValuesBucket[] = [
      {
        'avatar': 'app.media.avatar1',
        'name': '爱情转移',
        'message': '回忆是抓不到的月光握紧就变黑暗',
        'time': '9:06'
      },
      {
        'avatar': 'app.media.avatar8',
        'name': '谁来剪月光',
        'message': '最怕一边忙啊忙，一边回想那旧时光，剪不掉的是你，带泪的脸，还真是烦',
        'time': '8:59'
      },
      {
        'avatar': 'app.media.avatar2',
        'name': '富士山下',
        'message': '谁能凭爱意把富士山私有',
        'time': '8:56'
      },
      {
        'avatar': 'app.media.avatar3',
        'name': '十年',
        'message': '如果那两个字没有颤抖，我不会发现我难受',
        'time': '7:76'
      },
      {
        'avatar': 'app.media.avatar6',
        'name': '因为爱情',
        'message': '有时会忘了，我还在爱着你',
        'time': '昨天'
      },
      {
        'avatar': 'app.media.avatar4',
        'name': '浮夸',
        'message': '那年十八，母校舞会，站着如喽啰',
        'time': '昨天'
      },
      {
        'avatar': 'app.media.avatar5',
        'name': ' 你的背包',
        'message': '你的背包让我走得好缓慢，终有一天陪着我腐烂',
        'time': '周一'
      },

      {
        'avatar': 'app.media.avatar7',
        'name': '你给我听好',
        'message': '你给我听好，想哭就要笑',
        'time': '周日'
      }
    ]
    ChatUtil.addChatList(list)
    ChatUtil.getAllChat()
  }

  build() {
    Column() {

    }
    .height('100%')
    .width('100%')
  }
}
