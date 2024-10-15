class TitleChange{
  changeTitle(index:number):string{
    switch(index){
      case(0):return '微信'
      case (1):return '通讯录'
      case (2):return '发现'
      case (3):return '我的'
      default :return '错误'
    }
  }
}
let TitleChangeUtil = new TitleChange()
export default TitleChangeUtil as TitleChange