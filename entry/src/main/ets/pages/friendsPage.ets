import { router } from '@kit.ArkUI'
import { hear } from './common/Header'

@Entry
@Component
export struct friendsPage {
  build() {
    Column() {
      Text('通讯录界面')
        .fontSize(50)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#eeeeee')
  }
}