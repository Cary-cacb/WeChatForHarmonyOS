import relationalStore from '@ohos.data.relationalStore';
import { User } from '../entity/User'
import { Context } from '@kit.AbilityKit';
import { ValuesBucket } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { Chat } from '../entity/Friend';


class ChatData {
  private rdbStore: relationalStore.RdbStore | undefined = undefined
  private tableName: string = 'Chat'

  createDB(context: Context) {
    // rdb配置
    const config: relationalStore.StoreConfig = {
      name: 'Demo1DB.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    const sql = `create table if not exists Chat(
                 name    text not null,
                 message text not null default '默认信息',
                 avatar  text not null default 'app.media.foreground' ,
                 time    text not null
                  );`

    // 获取rdbStore实例globalThis.
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        //获取rdbStore实例失败的业务逻辑
        console.log('获取rdbStore失败 errCode:' + err.code)
      }
      // 获取rdbStore成功的业务逻辑
      rdbStore.executeSql(sql)
      console.log('建表', '成功创建Chat表！')
      //保存redStore
      this.rdbStore = rdbStore
    })
  }

  getAllChat(): Chat[] {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    let result = this.rdbStore?.querySync(predicates)
    let chats: Chat[] = []
    if (result?.isAtLastRow) {
      console.log("查询Chat 数据库为空")

    } else {
      console.log('查询Chat 有结果')
      console.log('查询Chat 共有' + result?.rowCount)
    }
    while (result?.goToNextRow()) {

      let avatar = result?.getString(result.getColumnIndex('avatar'))
      let name = result?.getString(result.getColumnIndex('name'))
      let message = result?.getString(result.getColumnIndex('message'))
      let time = result?.getString(result.getColumnIndex('time'))
      if (avatar && name && message && time) {
        let a = new Chat(avatar, name, message, time)
        chats.push(a)
        console.log('查询结果' + a.name)
      }
    }
    console.log('查询', JSON.stringify(chats))
    return chats

  }

  getChat(name: string): Chat {
    //1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('name', name)
    //2.查询
    let result = this.rdbStore?.querySync(predicates)
    //3.解析查询结果
    //定义一个数组来组装最终的查询结果
    if (result?.goToNextRow()) {
      let avatar = result?.getString(result.getColumnIndex('avatar'))
      let message = result?.getString(result.getColumnIndex('message'))
      let time = result?.getString(result.getColumnIndex('time'))
      //封装
      let chat = new Chat(avatar, name, message, time)
      console.log('testTag' + '查询到用户')
      return chat
    }
    console.log('没查询到用户！')
    return new Chat('', '', '', '')
  }

  addChat(avatar: string, name: string, message: string, time: string) {
    const chat: ValuesBucket = {
      'avatar': avatar,
      'name': name,
      'message': message,
      'time': time
    }
    this.rdbStore?.insert(this.tableName, chat,
      relationalStore.ConflictResolution.ON_CONFLICT_ROLLBACK
      , (err: BusinessError) => {
        if (err) {
          console.error(`键入Insert , errCode ${err.code}`)
          return
        } else {
          console.info(`键入Insert successful`)

        }
      })
  }

  addChatList(chats: ValuesBucket[]) {
    this.rdbStore?.batchInsert(this.tableName, chats, (err, num) => {
      if (err) {
        console.error(`插入列表 batchInsert is failed, code is ${err.code},message is ${err.message}`);
        return;
      }
      console.info(`插入列表 batchInsert is successful, the number of values that were inserted = ${num}`)
    })
  }

  // updateChat(name_old:string,name_new:string,password:string){
  //   let predicates = new relationalStore.RdbPredicates(this.tableName)
  //   predicates.equalTo('username',name_old)
  //   const usr: ValuesBucket = {
  //     'username': name_new,
  //     'password': password
  //   }
  //   this.rdbStore?.update(usr,predicates)
  //
  // }

  deleteChat(name: string) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('name', name)
    this.rdbStore?.delete(predicates)

  }
}


let ChatUtil = new ChatData()

export default ChatUtil as ChatData


