// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import { speakText, playSound } from "./controllers/audio.js";
import { copyUrlTitle } from "./controllers/copyUrlTitle.js";

// 関数をグローバルに利用可能にするため、windowオブジェクトに設定
window.speakText = speakText;
window.playSound = playSound;
window.copyUrlTitle = copyUrlTitle;
