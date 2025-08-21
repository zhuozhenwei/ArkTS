// 跳转页面入口函数
@Builder
export function StartBuilder() {
  Start();
}

@Component
struct Start {
  // 控制跳转的对象
  pathStack: NavPathStack = new NavPathStack();

  // 过3s后自动跳转到布局页，方法：计时3s
  aboutToAppear(): void { //生命周期
    setTimeout(() => {
      this.pathStack.replacePathByName('Layout', null, false)
    }, 3000) //以毫秒为单位
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image($r('app.media.ad'))
          .width('100%')
          .height('100%')
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        Button('跳过')
          .backgroundColor(Color.Gray)
          .margin(15)
          .onClick(() => {
            this.pathStack.replacePathByName('Layout', null, false)
          })
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}