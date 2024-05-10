#!/bin/bash
cat <<EOF >index.html
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="mdui/css/mdui.min.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<title>CrossMusicPlayer</title>
<div class="mdui-appbar  mdui-appbar-fixed">
<div class="mdui-toolbar mdui-color-indigo">
<a  class="mdui-typo-title">CrossMusicPlayer</a>
</div>
</head>
<body class="mdui-appbar-with-toolbar mdui-drawer-body-right">
</div>
</div>
</div>
<div class="mdui-container">
EOF
cat <<EOF >>index.html
<audio id='play' controls class='mdui-center' autoplay></audio>
<h3 id='current'></h3>
<h3 id='mode'></h3>
<a onclick="luanxu()" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">Random</a>
<a onclick="xunhuan()" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">Loop</a>
<a onclick="shunxu()" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">Sequential</a>
<table id="表格" border="1" class="mdui-table-col-numeric mdui-table">
  <thead>
    <tr>
      <th>FileName</th>
      <th>Play</th>
    </tr>
  </thead>
EOF

i=0
for name in `ls music`
do
cat <<EOF >>index.html
<tbody><tr><td>$name</td><td><a id="$i" onclick="play('$name',$i)" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-indigo">Play</a></td></tr>
EOF
let i=i+1
done
cat <<EOF >>index.html
<p id=count style='display: none'>$i<p>
EOF
cat <<EOF >>index.html
</tbody>
</table>
<script>
mode = 'shunxu';
document.getElementById("mode").innerHTML='Mode：Sequential'
function luanxu() {
    mode = 'luanxu';
    document.getElementById("mode").innerHTML='Mode：Random';
}
function xunhuan() {
    mode = 'xunhuan';
    document.getElementById("mode").innerHTML='Mode：Loop'
}
function shunxu() {
    mode = 'shunxu';
    document.getElementById("mode").innerHTML='Mode：Sequential'
}
function play(name, id) {
   document.getElementById('play').src = 'music/' + name;
  document.getElementById('current').innerHTML = 'Playing：' + name;
}
document.getElementById("play").addEventListener('ended', function () {
       if(mode=='luanxu') {
       count = document.getElementById('count').innerHTML
       sid = Math.floor(Math.random()*count + 1);
       playnext = document.getElementById(sid).onclick
       playnext();
       }
       if(mode=='shunxu') {
       id = id + 1
       playnext = document.getElementById(id).onclick
       playnext();
       }
       if(mode=='xunhuan') {
       playnext = document.getElementById(id).onclick
       playnext();
       }
   }, false);
</script>
EOF


cat <<EOF >>index.html
</div>
<script src="mdui/js/mdui.min.js"></script>
</body>
</html>
EOF
