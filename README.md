# Hi, Kkojangro!

## **Fork를 통한 협업**

### 원본(메인) 레포에서 브랜치를 생성하여 작업을 하는 것이 아니라

각자 레포를 fork한 후, 본인(포크한) 레포에서 작업을 한 이후 원본(메인)레포에 PR을 요청하는 방식으로 진행하는 방법입니다.

- Fork를 통해 진행하는 이유
    - 원본 레포의 브랜치에서 작업을 하다보면 누군가가 작업을 하는 도중에 다른 사람이 작업을 진행하게 되면, conflict가 날 확률이 매우 높아지기 때문에, 각자 작업을 한 뒤, 원본 레포에 merge를 진행하여 conflict를 방지하기 위해 진행합니다.
1. 원본 레포를 fork하여 내 레포에 생성합니다.
2. 원하는 디렉토리에 git을 초기화 시켜줍니다.

`git init`

3. 원본(메인) 레포를 upstream으로 remote해줍니다.

`git remote add upstream <원본(메인)레포 주소>`

4. 로컬(나의) 레포를 origin으로 remote해줍니다.

`git remote add origin <로컬(포크한 나의)레포 주소>`

**작업을 진행할 시 upstream에서 pull을 받아오고, origin으로 push를 날려주어 pr을 진행합니다.**

→ 공동 작업물을 받아와서 내 개인 컴퓨터로 작업을 한 뒤, 공동 작업물에 합칠 수 있도록 진행하는 것

1. 이슈 템플릿에 맞춰 원본(메인) 레포에 이슈를 생성합니다.
    - New issue를 클릭하여 이슈를 생성합니다.
    - **[Prefix] 작업 목표** ex) [Design] Weather View 디자인
2. 이슈를 만들면 이슈 제목에 이슈 번호가 생성되는데, (ex) ~/#7) 로컬에 feature/#이슈번호 브랜치를 생성합니다.

`git branch feature/#7    //이슈번호7의 브랜치 생성`

3. 해당 브랜치로 이동하여 작업을 합니다.

`git switch feature/#7    //해당 브랜치로 변경`

4. 작업이 끝난 뒤, add와 commit을 진행합니다.

`git add .    //작업 요소를 더해줌
`git commit -m "[Prefix] <앱 이름>#이슈번호 - Weather View 디자인 구현"    //무엇을 구현했는지 메세지로 작성`

5. 내가 작업을 하는 도중에 다른 사람이 작업을 진행하여 원본(메인)레포가 변경되어 있을 수도 있으니, (확인을 위해) pull을 한 번 진행해준다.

`git pull upstream develop    //원본(메인)레포의 파일을 불러온다.`

6. 에러가 나지 않았다면, origin에서 작업한 내용을 push해준다.

`git push -u origin <브랜치명>    //해당 브랜치를 올리고자 한다.`

7. PR을 통해 코드 리뷰를 진행한 뒤, approve를 해준다면 merge를 한다.
8. 기본 브랜치로 돌아옵니다.

`git switch develop(main)`

9. 1번부터 다시 진행을 하며 작업을 반복하면 됩니다.

## Git Branch Convention

- 브랜치를 생성하기 전에, 이슈를 작성해야 하는데, **[브랜치 종류]/#<이슈번호>**의 양식에 따라 브랜치 명을 작성합니다.
- 브랜치 종류
    - develop : feature 브랜치에서 구현된 기능들이 merge될 브랜치. default 브랜치입니다.
    - **feature** : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발합니다. 주로 많이 사용합니다.
    - main : 개발이 완료된 산출물이 저장될 공간
    - release : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
    - bug : 버그를 수정하는 브랜치
    - hotfix : 정말 급하게, 제출 직전에 에러가 난 경우 사용하는 브렌치

ex) feat/#6

## Commit Convention

- commit은 최대한 자세히 나누어서 진행해야 하기 때문에, 하나의 이슈 안에서도 매우 많은 commit이 생성될 수 있습니다. **[prefix] (해당 앱 이름(옵션))#이슈번호 - 이슈 내용**의 양식에 따라 커밋을 작성합니다.
- prefix 종류
    - [Feat]: 새로운 기능 구현
    - [Setting]: 기초 세팅 관련
    - [Design]: just 화면. 레이아웃 조정
    - [Fix]: 버그, 오류 해결, 코드 수정
    - [Add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
    - [Del]: 쓸모없는 코드, 주석 삭제
    - [Refactor]: 전면 수정이 있을 때 사용합니다
    - [Remove]: 파일 삭제
    - [Chore]: 그 이외의 잡일/ 버전 코드 수정, 패키지 구조 변경, 파일 이동, 파일이름 변경
    - [Docs]: README나 WIKI 등의 문서 개정
    - [Comment]: 필요한 주석 추가 및 변경

ex) [Design] DreamLog#4 - 응원 뷰 레이아웃 디자인

## Issue

### 이슈 생성 시

- [Prefix] 뷰이름 이슈명 ex) [Design] MyView - MyView 레이아웃 디자인
- 우측 상단 Assignees 자기 자신 선택 → 작업 할당된 사람을 선택하는 것
- Labels Prefix와 자기 자신 선택

## PR

### PR 요청 시

- Reviewers 자신 제외 모두 체크
- Assignees 자기 자신 추가
- Labels 이슈와 동일하게 추가
- 서로 코드리뷰 꼭 하기
- 수정 필요 시 수정하기

## 📁폴더링
