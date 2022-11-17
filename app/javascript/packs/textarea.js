window.onload = function() {
  this.resizeTextarea = () => {
    const PADDING_Y = 20;
    const $textarea = document.getElementById("textarea");
    let lineHeight = getComputedStyle($textarea).lineHeight;
    lineHeight = lineHeight.replace(/[^-\d\.]/g, '');
    const lines = ($textarea.value + '\n').match(/\n/g).length;
    $textarea.style.height = lineHeight * lines + PADDING_Y + 'px';
  };
};
