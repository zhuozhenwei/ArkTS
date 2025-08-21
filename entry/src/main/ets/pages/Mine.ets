interface AccountStat {
  label: string
  value: string
}

interface UserInfo {
  decade: string
  zodiac: string
  city: string
  yearsOfMusic: string
}

@Component
export struct Mine {
  private userInfo: UserInfo = {
    decade: '00后',
    zodiac: '双子座',
    city: '北京',
    yearsOfMusic: '歌龄·18年'
  }
  private stats: AccountStat[] = [
    { label: '关注', value: '1' },
    { label: '粉丝', value: '100万' },
    { label: '获赞', value: '1.67亿' }
  ]

  build() {
    Column() {
      // 图片区域：堆叠，大图在下层，logo 在上层，底部居中
      Stack({ alignContent: Alignment.Bottom }) {
        Image($r('app.media.img'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)

        Image($r('app.media.logo'))
          .width(96)
          .height(96)
      }
      .width('100%')
      .height('70%')

      // 介绍区域：三行
      Column() {
        // 第一行：软件名字 + VIP
        Row({ space: 10 }) {
          Text('黑马云音乐')
            .fontColor(Color.White)
            .fontSize(25)

          Image($r('app.media.ic_vip'))
            .width(50)
            .height(25)
            .objectFit(ImageFit.Contain)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .margin({ top: 30, bottom: 30 })

        // 第二行：用户基本信息
        Row({ space: 12 }) {
          Text(this.userInfo.decade).fontColor('#767678')
          Text(this.userInfo.zodiac).fontColor('#767678')
          Text(this.userInfo.city).fontColor('#767678')
          Text(this.userInfo.yearsOfMusic).fontColor('#767678')
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .margin({ top: 10, bottom: 20 })

        // 第三行：账户信息（数字与文字垂直，整体水平排列）
        Row({ space: 12 }) {
          ForEach(this.stats, (item: AccountStat, _index: number) => {
            Row({ space: 4 }) {
              Text(item.value)
                .fontColor('#767678')
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
              Text(item.label)
                .fontColor('#767678')
                .textAlign(TextAlign.Center)
            }
          }, (item: AccountStat) => item.label)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .height('30%')
      .padding({
        left: 20,
        right: 20,
        top: 12,
        bottom: 16
      })
      .backgroundColor(Color.Black)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}