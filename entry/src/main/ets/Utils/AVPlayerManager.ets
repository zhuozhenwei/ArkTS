import { media } from '@kit.MediaKit'
import { GlobalMusic } from '../models/GlobalMusic'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'
import { sessionManager } from './AvSessionManager'

// 封装播放工具类
class AVPlayerManager {
  // 播放器
  player: media.AVPlayer | null = null
  // 共享播放数据
  currentSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  async init() {
    // 创建播放器
    if (!this.player) {
      this.player = await media.createAVPlayer()
    }
    // 监听播放器状态
    this.player.on('stateChange', (state) => {
      if (state == 'initialized') {
        this.player?.prepare()
      } else if (state == 'prepared') {
        this.player?.play()
        this.currentSong.isPlay = true
      } else if (state == 'completed') {
        // 播放完成
        this.currentSong.isPlay = false
        this.nextPlay(true)
      } else if (state == 'released') {
        this.currentSong.reset()
      }
    })
    // 监听歌曲总时长
    this.player.on('durationUpdate', (duration) => {
      this.currentSong.duration = duration
      sessionManager.setAVMetadata(this.currentSong.playList[this.currentSong.playIndex])
    })

    this.player.on('timeUpdate', (time) => {
      this.currentSong.time = time
      sessionManager.setAVPlayBackState()
    })
  }

  // 播放歌曲
  // singPlay(song: SongItemType) {
  //   this.player!.url = song.url
  //   this.currentSong.img = song.img
  // }
  singPlay(song: SongItemType) {
    // 需要申请长时任务
    sessionManager.startBackgroundTask()
    sessionManager.setAVPlayBackState()
    // 判断是否在列表里面 -> some用法 检查数组里面的数据是否满足条件 -> 只要有一个满足some就返回true
    const inList = this.currentSong.playList.some((item: SongItemType) => item.id == song.id)
    if (inList) { //在播放列表里面
      if (song.url == this.currentSong.url) { // 当前正在播放
        this.player?.play()
        this.currentSong.isPlay = true
      } else { // 当前不是正在播放，切歌
        this.currentSong.playIndex = this.currentSong.playList.findIndex((item: SongItemType) => item.id == song.id)
        // 切歌
        this.changeSong()
      }
    } else { // 不在播放列表里面，添加到列表 + 切换歌曲
      // unshift 表示加在数组的前面
      this.currentSong.playList.unshift(song)
      this.currentSong.playIndex = 0
      // 切歌
      this.changeSong()
    }
  }

  // 切换歌曲
  async changeSong() {
    // 先重置播放器（需要等待 await）
    await this.player?.reset()
    this.currentSong.duration = 0
    this.currentSong.time = 0
    this.currentSong.img = this.currentSong.playList[this.currentSong.playIndex].img
    this.currentSong.name = this.currentSong.playList[this.currentSong.playIndex].name
    this.currentSong.author = this.currentSong.playList[this.currentSong.playIndex].author
    this.currentSong.url = this.currentSong.playList[this.currentSong.playIndex].url
    // 歌曲地址：!表示player播放器非空
    this.player!.url = this.currentSong.url
  }

  paused() {
    this.player?.pause()
    this.currentSong.isPlay = false
    sessionManager.setAVPlayBackState()
  }

  // 上一首
  prePlay() {
    // console.log('当前播放列表:', this.currentSong.playList.length)
    // 因为在上一首这里不存在自动切换到上一首
    if (this.currentSong.playMode == 'random') { // 随机播放
      this.currentSong.playIndex = Math.floor(Math.random() * this.currentSong.playList.length)
    } else { // 列表播放
      this.currentSong.playIndex--
      if (this.currentSong.playIndex < 0) {
        this.currentSong.playIndex = this.currentSong.playList.length - 1
      }
    }
    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  // 下一首
  nextPlay(autoNextPlay?: boolean) {
    // console.log('当前播放列表:', this.currentSong.playList.length)
    // 重复播放：播放模式为repeat并且播放器自动下一首 completed 传入一个数据表示是自动切换下一首
    if (this.currentSong.playMode == 'repeat' && autoNextPlay) {
      this.currentSong.playIndex = this.currentSong.playIndex
    } else if (this.currentSong.playMode == 'random') { // 随机播放
      // Math.random()属于[0,1)
      this.currentSong.playIndex = Math.floor(Math.random() * this.currentSong.playList.length)
    } else { // 列表播放
      this.currentSong.playIndex++
      if (this.currentSong.playIndex >= this.currentSong.playList.length) {
        this.currentSong.playIndex = 0
      }
    }

    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  seekPlay(value: number) {
    this.player?.seek(value)
  }

  // 列表移除歌曲
  removeSong(index: number) {
    if (index == this.currentSong.playIndex) {
      // 删除的是正在播放的歌曲
      if (this.currentSong.playList.length > 1) {
        // 列表里面有多首歌
        this.currentSong.playList.splice(index, 1)
        if (this.currentSong.playIndex >= this.currentSong.playList.length) {
          this.currentSong.playIndex = 0
        }
        this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
      } else {
        // 列表里面只有这一首歌
        this.currentSong.playList.splice(index, 1)
        // 播放器重置
        this.player?.reset()
        // 数据重置
        this.currentSong.reset()
      }
    } else {
      // 删除的不是正在播放的歌曲
      if (index < this.currentSong.playIndex) {
        this.currentSong.playIndex--
      }
      // splice：删除
      this.currentSong.playList.splice(index, 1)
    }
  }

  // 释放播放器 和 播放数据
  async release() {
    await this.player?.release()
  }
}

export const playerManager: AVPlayerManager = new AVPlayerManager()










