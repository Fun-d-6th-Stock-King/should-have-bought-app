# 그때 살껄(Should Have Bought)


##  Struct

```
assets
    ㄴ images 
    ㄴ fonts
lib
    ㄴ models  - - - - model로 사용될 모듈
    ㄴ providers - - - Provider 상태관리로 사용 될 model, provider_list.dart의 kProviders 에 리스트화.
                       main.dart 의 providers에 사용
    ㄴ screens - - - - 화면(page) 단위로 사용 될 모듈
    ㄴ widgets - - - - 기능(widget) 단위로 사용 될 모듈
    constant.dart  - - style 등 정의 변수 이름은 k로 시작 Ex) kTextStyle
    routes.dart  - - - named Screen으로 사용 할 스크린 페이지 목록. main.dart 의 routes에 사용
```


## Convention

- 기본적으로 `effective_dart` 룰을 따른다.
    - 무시 된 목록은 `analysis_options.yaml` 파일 참고

**상수**
- 변수 앞에 `k`를 붙여 정의  _Ex) kTextStyle_

**기타**
- providers, routes 는 각각 `providers_list.dart` , `routes.dart` 에 작성된 예시를 참고
