import relationalStore from '@ohos.data.relationalStore';
import { User } from '../entity/User'
import { Context } from '@kit.AbilityKit';
import { ValuesBucket } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';


class DatabaseUtil {
  private rdbStore?: relationalStore.RdbStore
  private tableName: string = 'User'

  createDB(context: Context) {
    // rdb配置
    const config: relationalStore.StoreConfig = {
      name: 'Demo1DB.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    const sql = `create table if not exists User(
                 username text not null,
                 password text not null,
                 avatar   text default 'app.media.foreground' null,
                 primary key (username)
                  );`
    // 获取rdbStore实例globalThis.
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        //获取rdbStore实例失败的业务逻辑
        console.log('获取rdbStore失败 errCode:' + err.code)
      }
      // 获取rdbStore成功的业务逻辑
      rdbStore.executeSql(sql)
      console.log('testTaf', '成功创建User表！')
      //保存redStore
      this.rdbStore = rdbStore
    })
  }

  async getAllUser() {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    let result = await this.rdbStore?.query(predicates)
    let users: User[] = []
    if (!result?.isAtLastRow) {
      console.log("查询：数据库为空")

    } else {
      console.log('查询:有结果')
      console.log('查询共有' + result.rowCount.toString() + '\t' + result.columnNames.toString())
    }
    while (!result?.isAtLastRow) {

      let name = result?.getString(result.getColumnIndex('username'))
      let pass = result?.getString(result.getColumnIndex('password'))
      let adv = result?.getString(result.getColumnIndex('avatar'))
      let a = new User(name ? name : '1', pass ? pass : '1', adv ? adv : '1')
      users.push(a)
      console.log('查询结果' + a.UserName)

    }
    console.log('查询', JSON.stringify(users))

  }

  async getUser(username: string): Promise<User> {
    //1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('username', username)
    //2.查询
    let result = await this.rdbStore?.query(predicates, ['password', 'avatar'])
    //3.解析查询结果
    //定义一个数组来组装最终的查询结果

    if (!result?.isAtLastRow && result) {
      result.goToNextRow()
      let password = result.getString(result.getColumnIndex('password'))

      let avatar = result.getString(result.getColumnIndex('avatar'))
      //封装
      let user = new User(username, password, avatar)
      console.log('testTag' + '查询到用户')
      console.log(`查询${user.Password}`)
      return user
    }
    console.log('没查询到用户！')
    return new User('', '', '')
  }

  addUser(name: string, password: string) {
    const user: ValuesBucket = {
      'username': name,
      'password': password
    }
    this.rdbStore?.insert(this.tableName, user,
      relationalStore.ConflictResolution.ON_CONFLICT_ROLLBACK
      , (err: BusinessError) => {
        if (err) {
          console.error(`查询Insert , errCode ${err.code}`)
          return
        } else {
          console.info(`查询Insert successful`)
        }
      })
  }

  updateUser(name_old: string, name_new: string, password: string) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('username', name_old)
    const usr: ValuesBucket = {
      'username': name_new,
      'password': password
    }
    this.rdbStore?.update(usr, predicates)

  }

  deleteUser(name: string) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('username', name)
    this.rdbStore?.delete(predicates)

  }
}

let UserModel = new DatabaseUtil()

export default UserModel as DatabaseUtil


