@Observed
export class User{
  UserName:string
  Password:string
  Avatar:string

  constructor(UserName:string, Password:string,Avatar:string) {
    this.UserName = UserName;
    this.Password = Password;
    this.Avatar = Avatar;
  }
}