#!/bin/sh
# sw - suckless webframework - 2012 - MIT License - nibble <develsec.org>

sw_filter() {
	[ -n "$(echo $1 | grep '\..html')" ] && return 0
	for b in $BL; do
		[ "$b" = "$1" ] && return 0
	done
}

sw_main() {
	$MDHANDLER "$1"
}

sw_menu() {
	echo "<ul>"
	[ "$(dirname "$1")" != "." ] && echo "<li><a href=\"../index.html\">..</a></li>"
	ls "$(dirname "$1")" | sed -e 's,.md$,.html,g' | while read i ; do
		sw_filter "$i" && continue
		NAME=$(echo $i | sed -e 's/\..*$//')
		[ -z "$(echo $i | grep '\..*$')" ] && i="$i/index.html"
		echo "<li><a href=\"$i\">$NAME</a></li>"
	done
	echo "</ul>"
}

sw_page() {
	# Header
	cat << _header_
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${TITLE}</title>
<link rel="icon" href="/favicon.png" type="image/png">
_header_
	# Stylesheet
	sw_style
	cat << _header_
</head>
<body>
<div class="header">
<h1 class="headerTitle">
<a href="$(echo $1 | sed -e 's,[^/]*/,../,g' -e 's,[^/]*.md$,index.html,g')">${TITLE}</a> <span class="headerSubtitle">${SUBTITLE}</span>
</h1>
</div>
_header_
	# Menu
	echo "<div id=\"side-bar\">"
	sw_menu "$1"
	echo "</div>"
	# Body
	echo "<div id=\"main\">"
	sw_main "$1"
	echo "</div>"
	# Footer
	cat << _footer_
<div id="footer">
<div class="right"><a href="https://github.com/jroimartin/sw">Powered by sw</a></div>
</div>
</body>
</html>
_footer_
}

sw_style() {
	if [ -f "$CDIR/$STYLE" ]; then
		echo '<style type="text/css">'
		cat "$CDIR/$STYLE"
		echo '</style>'
	fi
}

# Set input dir
IDIR="$(echo $1 | sed -e 's,/*$,,')"
if [ -z "$IDIR" ] || [ ! -d "$IDIR" ]; then
	echo "Usage: sw [dir]"
	exit 1
fi

# Load config file
if [ ! -f "$PWD/sw.conf" ]; then
	echo "Cannot find sw.conf in current directory"
	exit 1
fi
. "$PWD/sw.conf"

# Setup output dir structure
CDIR=$PWD
ODIR="$CDIR/$(basename "$IDIR").static"
rm -rf "$ODIR"
mkdir -p "$ODIR"
cp -rf "$IDIR"/* "$ODIR"
find "$ODIR" -type f -iname '*.md' -delete

# Parse files
cd "$IDIR" || exit 1
find * -iname '*.md' | while read a ; do
	b="$ODIR/$(echo $a | sed -e 's,.md$,.html,g')"
	echo "* $a"
	sw_page "$a" > "$b"
done

exit 0
