# AutoBuild_ipa
利用脚本实现自动打包.ipa文件并上传到蒲公英。
目录结构：
![](http://upload-images.jianshu.io/upload_images/7567615-290649983d5a5435.png?imageMogr2/auto-orient/strip) 
使用方式:
1： 将xcodebuild.sh中User_Key，API_Key，project_name，scheme_name等变量设置正确；
2： 将AutoBuild文件夹放置于项目文件中和.xcodeproj平级 在终端中进入.xcodeproj上级目录 输入./AutoBuild/xcodebuild.sh即可自动打包；
