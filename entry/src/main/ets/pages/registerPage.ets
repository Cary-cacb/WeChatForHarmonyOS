import DatabaseUtil from './Utils/SQLiteUtil';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Reg {
  @State account: string = ''
  @State is_accopunt: boolean = false
  @State password: string = ''
  @State password_ag: string = ''
  @State is_password: boolean = false

  build() {

    Column() {
      Row() {
        Button() {
          Image($r('app.media.left_back')).height(40)
        }.height(40)
        .type(ButtonType.Circle)
        .onClick(() => {
          router.pushUrl({ url: 'pages/loginPage' })
        })

      }.justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({ top: 15, left: 15 })

      Column({ space: 20 }) {
        TextInput({ placeholder: '请输入账号' })
          .onChange(val => {
            this.account = val
            this.is_accopunt = true
          }).height(40)
        TextInput({ placeholder: '请输入密码' })
          .onChange(val => {
            this.password = val
          }).height(40)
          .type(InputType.Password)
        TextInput({ placeholder: '请再次输入密码' })
          .onChange(val => {
            this.password_ag = val
            this.is_password = true
          })
          .type(InputType.Password)
      }.width('95%')
      .margin({ top: 200 })
      .justifyContent(FlexAlign.Center)

      Button('注册')
        .onClick(() => {
          if (this.password === this.password_ag && this.is_accopunt && this.is_password) {
            DatabaseUtil.addUser(this.account, this.password)
            console.log('Enroll Success!')
            router.pushUrl({ url: 'pages/loginPage' })
          }
        })


    }.height('100%')
  }
}