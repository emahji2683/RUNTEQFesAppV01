// audio.js

// テキストから音声を生成する関数
export function speakText(text) {
  if (!text) return; // テキストが空の場合は何もしない
  const utterance = new SpeechSynthesisUtterance(text); // SpeechSynthesisUtteranceオブジェクトを作成
  utterance.lang = 'bn-IN'; // 言語を日本語に設定
  window.speechSynthesis.speak(utterance); // 音声を再生
}

export function stopSpeech() {
  window.speechSynthesis.cancel(); // 再生中の音声を停止
}

// 音声波形を生成する関数
export function playSound() {
  const audioContext = new (window.AudioContext || window.webkitAudioContext)(); // AudioContextの作成
  const oscillator = audioContext.createOscillator(); // オシレーター（発振器）の作成
  oscillator.type = 'sine'; // 波形の種類を指定（'sine'は正弦波）
  oscillator.frequency.setValueAtTime(440, audioContext.currentTime); // 周波数を設定（440Hz = A4音）

  oscillator.connect(audioContext.destination); // オシレーターをスピーカー（出力）に接続
  oscillator.start(); // 音の再生開始
  oscillator.stop(audioContext.currentTime + 2); // 2秒後に再生を停止
}

