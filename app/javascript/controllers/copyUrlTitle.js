export function copyUrlTitle() {
    const url = location.href;
    navigator.clipboard.writeText(url);
  }

  