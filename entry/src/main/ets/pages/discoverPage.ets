import { router } from '@kit.ArkUI'
import { hear } from './common/Header'

@Entry
@Component
export struct discoverPage {
  build() {
    Column() {
      Text('发现界面')
        .fontSize(50)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#eeeeee')

  }
}