# 그때 살껄(Should Have Bought)


##  Struct

|Directory|Path|Note|
|---------|----|----|
|assets | images|image 자료가 담길 디렉토리, 추후 icon 으로 나눌 수도 있음|
|assets | fonts|font 파일이 담길 디렉토리, Family 별로 세부 구분|
|lib | models|model로 사용될 모듈|
|lib | providers|Provider 상태관리로 사용 될 model, provider_list.dart의 kProviders 에 리스트화. main.dart 의 `providers`에 사용|
|lib | screens|화면(page) 단위로 사용 될 모듈|
|lib | widgets|기능(widget) 단위로 사용 될 모듈|
|./ | constant.dart|style 등 정의 변수 이름은 k로 시작 `Ex) kTextStyle`|
|./ | routes.dart|named Screen으로 사용 할 스크린 페이지 목록. main.dart 의 `routes`에 사용|



## Convention

- 기본적으로 `effective_dart` 룰을 따른다.
    - 무시 된 목록은 `analysis_options.yaml` 파일 참고

**상수**
- 변수 앞에 `k`를 붙여 정의  _Ex) kTextStyle_

**기타**
- providers, routes 는 각각 `providers_list.dart` , `routes.dart` 에 작성된 예시를 참고

## 개발 환경 세팅

### firebase google 연동

#### SHA-1 등록

1.
android studio로 open을 누르고 sholud-have-bought-app 프로젝트 내의 android를 최상위로 열기

android studio 우측 상단 gradle 클릭 - Tasks - android - signingReport 클릭

출력 되는 SHA1 입력

#### google-services.json 파일 추가

sholud-have-bought-app - android - app 하위에 추가


####

프로젝트 수준의 build.gradle (<project>/build.gradle):

```
buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
  }
  dependencies {
    ...
    // Add this line
    classpath 'com.google.gms:google-services:4.3.5'
  }
}

allprojects {
  ...
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
    ...
  }
}
```

앱 수준의 build.gradle (<project>/<app-module>/build.gradle):



apply plugin: 'com.android.application'
// Add this line
apply plugin: 'com.google.gms.google-services'

dependencies {

}

#### 연동 이슈시 참고
https://282-ground.tistory.com/181