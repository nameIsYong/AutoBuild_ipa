#echo ‘1：定义相关变量'

User_Key="98f53560d4a20a29f762ab29263889a9"
API_Key="5f13db6c1f7fb82094b2f8c8ec5a909c"
#替换project_name成你的工程名
project_name=ydl
#打包模式Debug/Release
development_mode=Debug
#scheme名
scheme_name=ydl
#plist文件所在路径
exportOptionsPlistPath=./AutoBuild/buildOptionsPlist.plist
#导出.ipa文件所在路径为桌面下文件夹名为ydl-ipa下
exportFilePath=~/Desktop/$project_name-ipa

#echo ‘2：正在清理缓存'
#xcodebuild \
#clean -configuration ${development_mode} -quiet  || exit

echo '3：正在 编译工程'
xcodebuild archive -project ${project_name}.xcodeproj -scheme ${project_name} -archivePath build/${project_name}.xcarchive -quiet  || exit

echo '4：正在打包'
xcodebuild -exportArchive -archivePath build/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportFilePath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

echo '删除build的临时文件'
if [[ -d build ]]; then
    rm -rf build -r
fi

if [ -e $exportFilePath/$scheme_name.ipa ]; then

    ipaPath=$exportFilePath'/'$scheme_name.ipa
    echo 'ipa文件已导出 ：'$ipaPath
    cd ${exportFilePath}
    echo " 5：开始上传到蒲公英"

    RESULT=$(curl -F "file=@$ipaPath" -F "uKey=$User_Key" -F "_api_key=$API_Key" -F "publishRange=2" http://www.pgyer.com/apiv1/app/upload)

    echo '上传成功'
    echo $RESULT
else
    echo 'ipa创建失败'
fi
echo '完成'