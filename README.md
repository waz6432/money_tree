# 👋 Money Tree 💰
> 가계부 어플


<br>

## 1. 제작 기간 & 참여 인원
- 2024년 10월 ~ 진행중

<br>

## 2. 사용 기술
#### `Front-end`
  - Flutter

#### `Back-end`
  - Mock API

<br>

## 3. ERD 설계


<br>


## [API 명세](https://www.notion.so/API-1290ca3231cc8099a5a3c89e15353361) 
⬆️ 제목(Notion 링크) 클릭해서 자세히보기

| Domain      | URL                                                                        | Http Method                 | description       | 접근 권한 |
|:------------|:---------------------------------------------------------------------------|:----------------------------|:------------------|:------|
| **Auth**    | /customers/login                                                           | `POST`                      | 사용자 로그인      | -     |
|             | /customers/register                                                        | `POST`                      | 사용자 회원가입    | -     |
|             | /customers/forgotPassword                                                  | `POST`                      | 사용자 패스워드 찾기       | -     |
| **Main**    | /home                                                                      | `GET`                       | 메인화면           | -     |
|             | /customers/report                                                          | `GET`                       | 리포트 출력 화면      | -     |
|             | /customers/newTransaction                                                  | `POST`                       | 지출금 등록 화면      | -     |


<br>

## 4. 핵심 기능

- 메인
  - 수입, 지출 확인
  - 계좌 거래 내역 확인
  - 최근 거래 내역 확인
- 리포트
  - 총 지출 변화율
  - 카테고리별 지출 내역
  - 데이터 시각화
  - 리포트 내보내기
- 지출 입력
  - 금액 입력
  - 메모 입력
- 설정
  - 언어 설정  
