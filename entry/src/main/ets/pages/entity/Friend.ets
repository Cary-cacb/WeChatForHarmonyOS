export class Chat{
  avatar: string
  name: string
  message: string
  time: string

  constructor(avatar: string, name: string, message: string, time: string) {
    this.avatar = avatar
    this.name = name
    this.message = message
    this.time = time
  }
}