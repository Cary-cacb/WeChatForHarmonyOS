import { router } from '@kit.ArkUI'
import DatabaseUtil from './Utils/SQLiteUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import { reminderAgentManager } from '@kit.BackgroundTasksKit';
import notificationUtil from './Utils/notificationUtil'


@Entry
@Component
struct login {
  //账号
  @Provide Account: string = 'root'
  @Provide Account_get: string = ''
  @State IsAccount: boolean = false
  //密码
  @Provide Password: string = '123456'
  @Provide Password_get: string = ''
  @State IsPassword: boolean = false
  //头像
  @State Avatar: Resource = $r('app.media.foreground')

  //发送系统定时通知
  aboutToAppear(): void {
    let timer: reminderAgentManager.ReminderRequestTimer = {
      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_TIMER,
      triggerTimeInSeconds: 10,
      title: "登陆界面后台代理倒计时通知"
    }

    reminderAgentManager.publishReminder(timer, (err: BusinessError, reminderId: number) => {
      if (err) {
        console.error("我尼玛callback err code:" + err.code + " message:" + err.message);
      } else {
        console.log("我尼玛callback, reminderId = " + reminderId);
      }
    });
  }

  build() {
    Column() {
      //头像
      Row() {
        Image(this.Avatar)
          .height(130)
      }.width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 160, bottom: 55 })

      //账号
      Row() {
        TextInput({ placeholder: '请输入账号' })
          .onChange((val: string) => {
            this.Account = val
            DatabaseUtil.getUser(val)
              .then(usr => {
                this.Account_get = usr.UserName
                this.Password_get = usr.Password
                this.Avatar = $r(usr.Avatar)
                if (this.Account === this.Account_get) {
                  this.IsAccount = true
                }
              })
          })
          .height(50)
      }
      .width('85%')
      .margin({ bottom: 30 })

      //密码
      Row() {
        TextInput({ placeholder: '请输入密码' })
          .onChange((val: string) => {
            this.Password = val
            if (this.Password === this.Password_get) {
              this.IsPassword = true
            }

          })
          .height(50)
          .type(InputType.Password)
      }
      .width('85%')
      .margin({ bottom: 50 })

      //登陆注册按钮
      Row() {
        Button('登录')
          .fontSize(23)
          .type(ButtonType.Capsule)
          .height(50)
          .width(120)
          .onClick(() => {
            notificationUtil.publish()
            DatabaseUtil.getAllUser()
            //成功登录
            if (this.IsAccount && this.IsPassword) {
              router.replaceUrl({
                url: 'pages/mainPage',
                params: '1'
              },
              )
            } else {
              AlertDialog.show({
                message: '账户或密码错误',
                backgroundColor: 'gray',
                width: 250,
                showInSubWindow: true,
                offset: { dx: 0, dy: 320 }

              })
            }


          })

        Button('注册')
          .type(ButtonType.Capsule)
          .fontSize(23)
          .height(50)
          .width(120)
          .onClick(() => {

            router.pushUrl({ url: 'pages/registerPage' })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

    }.height('100%')

  }
}
