import { notificationManager } from '@kit.NotificationKit';
import { BusinessError } from '@kit.BasicServicesKit';

class notificationUtil {
  publish() {
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 1,
      notificationSlotType: notificationManager.SlotType.SOCIAL_COMMUNICATION,
      isAlertOnce: false,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: '手动发送的通知',
          text: 'text显示在?',
          additionalText: 'additionalText显示在?'
        }
      }
    }
    notificationManager.publish(notificationRequest, (err: BusinessError) => {
      if (err) {
        console.error("notificationPublish error " + err)
      } else {
        console.info("notificationPublish succeed")
      }
    })
  }
}

let NotificationUtil = new notificationUtil()

export default NotificationUtil as notificationUtil
