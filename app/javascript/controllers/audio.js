// audio.js

// テキストから音声を生成する関数
export function speakText(text) {
  if (!text) return; // テキストが空の場合は何もしない
  const utterance = new SpeechSynthesisUtterance(text); // SpeechSynthesisUtteranceオブジェクトを作成
  utterance.lang = 'ja-JP'; // 言語を日本語に設定
  window.speechSynthesis.speak(utterance); // 音声を再生
}



