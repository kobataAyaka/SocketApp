# SocketApp
소켓통신 샘플프로젝트

## UDP + Network
Network 프레임워크를 이용한 UDP 통신입니다.

### UDP기능 이용법
1. 터미널에서 netcat listen 모드로 기동
```
% nc -l -u 12345
```

2. UDP 버튼을 눌러서 문자열 송신

![iOS.png](https://github.com/kobataAyaka/SocketApp/blob/images/iOS.png)

3. 터미널에 송신한 문자열이 표시됩니다.

![terminal.png](https://github.com/kobataAyaka/SocketApp/blob/images/terminal.png)

## TCP + Network
Network 프레임워크를 이용한 TCP 통신입니다.

### TCP기능 이용법
1. 터미널에서 netcat listen 모드로 기동
```
% nc -l 12346
```

2. TCP 버튼을 눌러서 문자열 송신

![iOS_TCP.png](https://github.com/kobataAyaka/SocketApp/blob/images/iOS_TCP.png)

3. 터미널에 송신한 문자열이 표시됩니다.

![terminal_TCP.png](https://github.com/kobataAyaka/SocketApp/blob/images/terminal_TCP.png)

## WebSocket
URLSession을 이용한 WebSocket 통신입니다.

### WebSocket 기능 이용법
1. 앱의 "Connect" 버튼을 눌러 공개 테스트 서버(`wss://echo.websocket.events`)에 접속합니다.
2. 접속이 성공하면, 메시지 입력 필드에 텍스트를 입력하고 "Send" 버튼을 누릅니다.
3. 이 서버는 Echo 서버이므로, 송신한 메시지가 그대로 수신되어 로그에 표시됩니다.


