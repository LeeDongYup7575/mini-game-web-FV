# JSP+Servlet 기반 웹 게임 프로젝트

## 개요
이 프로젝트는 JSP와 Servlet을 활용하여 웹 게임 플랫폼을 구축하는 프로젝트입니다. 
사용자는 회원가입 및 로그인을 통해 미니 게임들을 즐길 수 있으며, 자유게시판과 공지사항을 통해 커뮤니티 활동도 가능합니다. 
또한, 관리자는 게임 및 유저 데이터를 관리하고 통계를 확인할 수 있습니다.

## 주요 기능
- **회원 관리**: 회원가입, 로그인, 로그아웃 등
- **게임 기능**: 미니 게임
- **커뮤니티**: 자유게시판, 공지사항
- **관리자 페이지**: 유저 및 게임 관리, 통계 제공

## 기술 스택
- **백엔드**: JSP, Servlet
- **프론트엔드**: HTML, CSS, JavaScript, jQuery
- **데이터베이스**: Oracle
- **기타**: Phaser.js TensorFlow.js 

## 설치 및 실행 방법
1. **환경 설정**
   - Eclipse IDE 실행
   - Apache Tomcat 서버 설정 (포트번호: 80)
   - Oracle 데이터베이스 설치 및 초기화
   - 필요 라이브러리: cos-05Now2002, json-simple-1.1.1, jstl-1.2, ojdbc8-23.2.0.0

2. **프로젝트 실행**
   - 프로젝트를 Eclipse에 불러오기
   - `web.xml`, `server.xml` 및 데이터베이스 연결 정보 확인
   - Tomcat 서버 실행 후 `http://localhost:80/` 접속

## 개발 일정
- **리서치 및 설계**: 1주 (완)
- **구현 단계**: 기능 개발
- **테스트/리팩토링 단계**: 버그 수정 및 성능 최적화
- **호스팅 단계**: 배포 및 운영

## 기여 방법
1. Sprint에 할당된 기능 개발
2. 해당 기능 branch에 commit합니다.
3. 개발 후 PR(Pull Request)을 생성합니다.
4. 코드 리뷰 후 병합합니다.
