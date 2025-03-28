# seonuk-set
terminal setting backup

# 🧰 유용한 터미널 명령어 정리

## 🐍 Conda / Python

### Conda 가상환경 제거
```bash
conda remove --name <환경_이름> --all
```

### requirements.txt로 패키지 설치
```bash
pip install -r requirements.txt
```

### 가상환경 활성화 및 비활성화 자동화
```bash
echo "myenv" > .conda_auto_env
```

> ❗ **Tip**: 패키지 설치 시 오류가 발생하면 Python 버전을 낮춰보자.

### 패키지 제거
```bash
pip uninstall <패키지이름>
```

### 아나콘다 가상환경명 비활성화 (프롬프트에 환경명 안 뜨게)
```bash
conda config --set changeps1 False
```

---

## 📂 디렉토리 / 파일 관리

### 디렉토리 용량 확인
```bash
du -sh <디렉토리명>
```

### 디렉토리 내부까지 강제 삭제
```bash
rm -rf <경로>
```

### VSCode에서 새 탭으로 파일 열기
```bash
code -r <파일명>
```

---

## 🐙 Git

### 기본 작업 흐름
```bash
git add <추가할 파일>
git status
git commit -m "<메시지>"
git push -u origin main
```

### 원격 변경 가져오기
```bash
git fetch origin      # 원격 변경사항 가져오기
git pull              # 가져온 변경사항 병합
```

---

## 🖥️ Tmux 조작법

### 세션 조작
```bash
tmux new -s <세션명>       # 세션 생성
tmux ls                    # 세션 목록 보기
tmux attach -t <세션명>    # 세션 붙기
tmux kill-session -t <세션명>  # 세션 종료
```

### 단축키 (Ctrl+b 누른 후 입력)
- `d` : 세션 detach (백그라운드 전환)
- `c` : 새 윈도우 생성
- `x` : 현재 윈도우 종료

---

## 🐞 Python 디버깅 (내장 디버거)

```python
breakpoint()
```

- `n` : 한 줄 실행 (next)
- `c` : 계속 실행 (continue)
- `p <변수명>` : 변수 값 출력
- `q` : 디버거 종료

---

## 💻 시스템 설정 & 모니터링

### 스택 크기 확인 및 확장
```bash
ulimit -s
ulimit -s unlimited
```

### PYTHONPATH 설정
```bash
export PYTHONPATH=/home/sukim/project/icefall-250113/icefall:$PYTHONPATH
```

---

## 📊 TensorBoard

```bash
tensorboard --logdir=/home/sukim/project/icefall-250113/icefall/egs/commonvoice/ASR/ema/es_decode_result/1/tensorboard --port=6006
```

---

## 🚀 GPU 사용량 실시간 모니터링

### 설치
```bash
pip install gpustat
```

### 실시간 감시
```bash
watch -n 1 gpustat
```
