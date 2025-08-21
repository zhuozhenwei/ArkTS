interface recommendDailyType {
  img: string // 图片
  title: string // 简介文字
  type: string // 标题文字
  top: string // 标题背景色
  bottom: string // 简介背景色
}

interface recommendListType {
  img: string
  title: string
  count: string
}

@Component
export struct Recommend {
  // 轮播图数据
  swiperList: string[] = [
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner1.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner2.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner3.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner4.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner5.png"
  ]
  // 每日推荐数据
  dailyRecommend: recommendDailyType[] = [
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      type: '每日推荐',
      top: '#660000',
      bottom: '#382e2f'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend2.png',
      title: '从 [Nothing on Me] 开启无限漫游',
      type: '私人漫游',
      top: '#382e2f',
      bottom: '#a37862'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend3.png',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      type: '华语流行',
      top: '#a37862',
      bottom: '#174847'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend4.png',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      type: '私人雷达',
      top: '#174847',
      bottom: '#174847'
    }
  ]
  // 推荐歌单数据
  recommendList: recommendListType[] = [
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list1.jpg',
      title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
      count: '270.9万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list2.jpg',
      title: 'Yasuo和更多好听的 | 华语私人雷达 | 回忆8090',
      count: '476.1万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list3.jpg',
      title: 'Trap Remix丨当欧美热单遇上毒性低音',
      count: '186.3万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list4.jpg',
      title: '满级人类进化之路必备BGM | 根本停不下来',
      count: '186.3万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list5.jpg',
      title: '认真去聆听这个世界的每一分每一秒 (强烈推荐)',
      count: '362.8万'
    }
  ]

  @Builder
  titleBuilder(title: string) {
    Row() {
      Text(title)
        .fontColor('#fff')
        .fontWeight(700)
        .layoutWeight(1)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
    .width('100%')
    .height(40)
  }

  build() {
    Column({ space: 10 }) {
      // 搜索框
      Row() {
        Image($r('app.media.ic_search'))
          .width(22)
          .fillColor('#817D83')
        TextInput({ placeholder: '奢香夫人' })
          .placeholderColor('#817D83')
          .padding({ left: 5 })
          .fontColor('#999')
          // 抛去左右的，剩下的尺寸都给TextInput组件
          .layoutWeight(1)
        Image($r('app.media.ic_code'))
          .width(20)
          .fillColor('#817D83')
      }
      .width('100%')
      .backgroundColor('#2D2B29')
      .border({ radius: 20 })
      .padding({ left: 8, right: 8 })

      // 轮播图组件
      Swiper() {
        ForEach(this.swiperList, (item: string) => {
          Image(item)
            .width('100%')
        })
      }
      .border({ radius: 10 })
      .autoPlay(true) //自动播放

      // 每日推荐
      Column() {
        this.titleBuilder('每日推荐')

        List() {
          ForEach(this.dailyRecommend, (item: recommendDailyType, index: number) => {
            ListItem() {
              Column() {
                Text(item.type)
                  .backgroundColor(item.top)
                  .width('100%')
                  .height(30)
                  .padding({ left: 5 })
                  .fontSize(14)
                  .fontWeight(700)
                  .fontColor('#fff')
                Image(item.img)
                  .width('100%')
                Text(item.title)
                  .backgroundColor(item.bottom)
                  .width('100%')
                  .padding(5)
                  .fontSize(14)
                  .fontColor('#fff')
                  // 最多显示两行
                  .maxLines(2)
                  // 文本溢出的显示形式为省略号
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .border({ radius: 10 })
              .width('40%')
              // .height(200)
              .margin({ right: 10 })
              .clip(true) // 裁剪
            }
          })
        }
        // .height()
        .scrollBar(BarState.Off)
        // 改变List的滑动方向
        .listDirection(Axis.Horizontal)
        .height(230)
      }

      // 推荐歌单
      Column() {
        this.titleBuilder('推荐歌单')
        List() {
          ForEach(this.recommendList, (item: recommendListType) => {
            ListItem() {
              Column() {
                Stack({ alignContent: Alignment.TopStart }) {
                  Image(item.img)
                    .width('100%')
                    .height(100)
                    .border({ radius: 8 })
                  Text(item.count)
                    .fontColor('#fff')
                    .fontSize(12)
                    .fontWeight(700)
                    .margin(5)
                }

                Text(item.title)
                  .fontColor('#fff')
                  .fontSize(14)
                  .width('100%')
                  .padding(5)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('30%')
              // .height(200)
              .margin({ right: 10 })
            }
          })
        }
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
        .height(200)
      }
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 10,
      right: 10,
      top: 15,
      bottom: 15
    })
  }
}