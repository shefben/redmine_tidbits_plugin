document.addEventListener("DOMContentLoaded", function() {
  // Function to add BBCode tags around the selected text

function addBBCode(openTag, closeTag) {
  const bodyField = document.querySelector("textarea[name='tid_bit[body]']");
  if (bodyField) {
    const start = bodyField.selectionStart;
    const end = bodyField.selectionEnd;
    const text = bodyField.value;
    const before = text.substring(0, start);
    const after = text.substring(end, text.length);
    bodyField.value = before + openTag + text.substring(start, end) + closeTag + after;
    bodyField.focus();
    bodyField.selectionStart = start + openTag.length;
    bodyField.selectionEnd = end + openTag.length;
  }
}
  // Initialize the toolbar buttons
  const buttons = [
    { name: 'bold', image: '/redmine/images/jstoolbar/bold.png', openTag: '[b]', closeTag: '[/b]', title: 'Bold' },
    { name: 'italic', image: '/redmine/images/jstoolbar/italic.png', openTag: '[i]', closeTag: '[/i]', title: 'Italic' },
    { name: 'underline', image: '/redmine/images/jstoolbar/underline.png', openTag: '[u]', closeTag: '[/u]', title: 'Underline' },
    { name: 'strike', image: '/redmine/images/jstoolbar/strike.png', openTag: '[s]', closeTag: '[/s]', title: 'Strikethrough' },
    { name: 'code', image: '/redmine/images/jstoolbar/code.png', openTag: '[code]', closeTag: '[/code]', title: 'Code' },
    { name: 'quote', image: '/redmine/images/jstoolbar/quote.png', openTag: '[quote]', closeTag: '[/quote]', title: 'Quote' },
    { name: 'font', image: '/redmine/images/jstoolbar/font.png', openTag: '[font=]', closeTag: '[/font]', title: 'Font' },
    { name: 'size', image: '/redmine/images/jstoolbar/size.png', openTag: '[size=]', closeTag: '[/size]', title: 'Font Size' },
    { name: 'color', image: '/redmine/images/jstoolbar/color.png', openTag: '[color=]', closeTag: '[/color]', title: 'Font Color' },
    { name: 'background', image: '/redmine/images/jstoolbar/background.png', openTag: '[bgcolor=]', closeTag: '[/bgcolor]', title: 'Background Color' },
    { name: 'link', image: '/redmine/images/jstoolbar/link.png', openTag: '[url]', closeTag: '[/url]', title: 'Link' },
    { name: 'unlink', image: '/redmine/images/jstoolbar/unlink.png', openTag: '', closeTag: '', title: 'Unlink' },
    { name: 'image', image: '/redmine/images/jstoolbar/image.png', openTag: '[img]', closeTag: '[/img]', title: 'Image' },
    { name: 'video', image: '/redmine/images/jstoolbar/video.png', openTag: '[video]', closeTag: '[/video]', title: 'Video' },
    { name: 'bullet', image: '/redmine/images/jstoolbar/bullet.png', openTag: '[list]', closeTag: '[/list]', title: 'Bullet List' },
    { name: 'number', image: '/redmine/images/jstoolbar/number.png', openTag: '[list=1]', closeTag: '[/list]', title: 'Numbered List' },
    { name: 'align-left', image: '/redmine/images/jstoolbar/align-left.png', openTag: '[left]', closeTag: '[/left]', title: 'Align Left' },
    { name: 'align-center', image: '/redmine/images/jstoolbar/align-center.png', openTag: '[center]', closeTag: '[/center]', title: 'Align Center' },
    { name: 'align-right', image: '/redmine/images/jstoolbar/align-right.png', openTag: '[right]', closeTag: '[/right]', title: 'Align Right' },
    { name: 'removeFormat', image: '/redmine/images/jstoolbar/removeformat.png', openTag: '', closeTag: '', title: 'Remove Formatting' }
  ];

  const toolbar = document.querySelector(".bbcode-toolbar");
  buttons.forEach(button => {
    const btn = document.createElement("button");
    btn.type = "button";
    btn.style.backgroundImage = `url(${button.image})`;
    btn.title = button.title;
    btn.addEventListener("click", () => addBBCode(button.openTag, button.closeTag));
    toolbar.appendChild(btn);
  });

  // Tab switching logic
  document.getElementById("editor-tab").addEventListener("click", function() {
    document.getElementById("editor-content").style.display = "block";
    document.getElementById("preview-content").style.display = "none";
    this.classList.add("selected");
    document.getElementById("preview-tab").classList.remove("selected");
  });

  document.getElementById("preview-tab").addEventListener("click", function() {
    const bbcode = document.querySelector("textarea[name='tid_bit[body]']").value;
    const html = BBRuby.to_html(bbcode);
    document.getElementById("preview-content").innerHTML = html;

    document.getElementById("editor-content").style.display = "none";
    this.classList.add("selected");
    document.getElementById("editor-tab").classList.remove("selected");
  });
});