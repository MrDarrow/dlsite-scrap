{ pkgs }:

  pkgs.writeShellScriptBin "dl-scrap" ''
  
  ${pkgs.wget}/bin/wget "https://www.dlsite.com/maniax/work/=/product_id/$1.html" -P /tmp

  url="$(grep img.dlsite.jp/modpub /tmp/$1.html | grep -o '".*"' | sed 's\"\\g' | grep -o 'https.*' | head -1)"

  rm /tmp/$1.html

  ${pkgs.wget}/bin/wget $url
  ${pkgs.wget}/bin/wget "$(echo $url | sed 's/_main/_sam_mini/')"
  ''
