# ArkTS
## 黑马云音乐鸿蒙项目
### 实现功能如下所示（部分）
#### 跳转
NavDestination组件<br>
控制跳转的对象：pathStack: NavPathStack = new NavPathStack();<br>
自动跳转：setTimeout<br>

#### 轮播图组件
Swiper<br>
自动播放：.autoPlay(true)<br>

#### 列表组件
List<br>
滑动条：.scrollBar(BarState.Off)<br>
滑动方向：.listDirection(Axis.Horizontal)<br>

#### 叠加组件
Stack<br>
排布方向：alignContent: Alignment.xxx<br>

#### AVPlayer管理
创建播放器：createAVPlayer<br>
播放器重置：reset()<br>
player.on监听播放器：状态改变stateChange，歌曲时长durationUpdate、timeUpdate<br>
释放播放器和播放数据：release()<br>

#### AVSession管理
申请长时任务：sessionManager.startBackgroundTask()<br>
设置元数据：setAVMetadata<br>
设置播放状态：setAVPlaybackState<br>
激活session：activate<br>
注销会话：destroy<br>

#### 应用全局UI状态存储
AppStorageV2实现数据共享<br>
AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!<br>
