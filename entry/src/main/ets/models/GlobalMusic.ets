import { SongItemType } from "./music"

@ObservedV2
export class GlobalMusic {
  @Trace img: string = "" // 音乐封面
  @Trace name: string = "" // 音乐名称
  @Trace author: string = "" // 作者
  @Trace url: string = "" // 当前播放链接
  @Trace time: number = 0 // 播放时间
  @Trace duration: number = 0 // 音乐的播放总时长

  // 歌曲列表
  @Trace playIndex: number = 0 // 当前播放的歌曲索引
  @Trace playList: SongItemType[] = [] //播放歌曲列表

  // 歌曲播放状态
  @Trace isPlay: boolean = false
  // 播放模式
  @Trace playMode: 'auto' | 'random' | 'repeat' = 'auto'

  // 重置数据初始值
  reset() {
    this.img = ""
    this.name = ""
    this.author = ""
    this.url = ""
    this.time = 0
    this.duration = 0
    this.isPlay = false
    this.playIndex = 0
    this.playList = []
    this.playMode = 'auto'
  }
}