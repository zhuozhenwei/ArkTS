import { AppStorageV2 } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  // 控制页面跳转的对象需要与子页面中的保持一致
  // pathStack: NavPathStack = new NavPathStack();
  // !表示非空断言
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navStack', () => new NavPathStack())!

  build() {
    Navigation(this.pathStack) {
    }
    .onAppear(() => {
      this.pathStack.pushPathByName("Start", null, false)
    })
    .hideNavBar(true) // 当为true时，不会显示这个首页；当为false时，广告页前面还会有一页，这不符合常规
  }
}