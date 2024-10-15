export class chatInfo {
  id: number = 1
  msg: string = ''
  time: Date = new Date()

  constructor(id: number, msg: string, time: Date) {
    this.id = id
    this.msg = msg
    this.time = time
  }
}