--[[----------------------------------------------------------------------------
HTML snippets
Tags from https://www.w3schools.com/TAGs/
------------------------------------------------------------------------------]]
snippets['html']['doc'] = [[
<!DOCTYPE html>
<html lang="en">
  head%1

  body
</html>]]

snippets['html']['a'] = '<a href="%1">%2</a>'

snippets['html']['abbr'] = '<abbr title="%1">%2</abbr>'

snippets['html']['address'] = [[
<address>
  %1
</address>]]

snippets['html']['area'] = '<area shape="%6{default,rect,circle,poly}" coords="%7" href="%8" alt="%9">'

snippets['html']['article'] = [[
<article>
  %1
</article>]]

snippets['html']['aside'] = [[
<aside>
  %1
</aside>]]

snippets['html']['audio'] = [[
<audio controls>
  source%1
  Your browser does not support the audio tag.
</audio>]]

-- No <b> tag here - use more semantically clear tags like <strong>

snippets['html']['base'] = '<base href="%1" target="%2{_blank,_parent,_self,_top}">'

snippets['html']['bdi'] = '<bdi>%1</bdi>'

snippets['html']['bdo'] = '<bdo dir="%1{rtl,ltr}">%2</bdo>'

snippets['html']['blockquote'] = [[
<blockquote cite="%1">
  %2
</blockquote>]]

snippets['html']['body'] = [[
<body>
  %1
</body>]]

snippets['html']['br'] = '<br>'

snippets['html']['button'] = '<button type="%1{button,reset,submit}">%2</button>'

snippets['html']['canvas'] = [[
<canvas id="%1" width="%2", height="%3">
  %4
  Your browser does not support the canvas tag.
</canvas>]]

snippets['html']['caption'] = '<caption>%1</caption>'

snippets['html']['cite'] = '<cite>%1</cite>'

snippets['html']['code'] = '<code>%1</code>'

snippets['html']['col'] = '<col span="%1">'

snippets['html']['colgroup'] = [[
<colgroup>
  col%1
</colgroup>]]

snippets['html']['data'] = '<data value="%1">%2</data>'

snippets['html']['datalist'] = [[
<datalist id="%1">
  option%2
</datalist>]]

snippets['html']['dd'] = '<dd>%1</dd>'

snippets['html']['del'] = '<del>%1</del>'

snippets['html']['details'] = [[
<details>
  summary%1
  p
</details>]]

snippets['html']['dfn'] = '<dfn title="%1">%2</dfn>'

snippets['html']['dialog'] = [[
<dialog>
  %1
</dialog>]]

snippets['html']['div'] = '<div>%1</div>'

snippets['html']['dl'] = [[
<dl>
  dt%1
  dd
</dl>]]

snippets['html']['dt'] = '<dt>%1</dt>'

snippets['html']['em'] = '<em>%1</em>'

-- No <embed> tag here - use more semantically clear tags like <iframe>, <img> etc

snippets['html']['fieldset'] = [[
<fieldset>
  legend%1
</fieldset>]]

snippets['html']['figcaption'] = '<figcaption>%1</figcaption>'

snippets['html']['figure'] = [[
<figure>
  img%1
  figcaption
</figure>]]

snippets['html']['footer'] = [[
<footer>
  %1
</footer>]]

snippets['html']['form'] = [[
<form>
  %1
</form>]]

snippets['html']['h1'] = '<h1>%1</h1>'
snippets['html']['h2'] = '<h2>%1</h2>'
snippets['html']['h3'] = '<h3>%1</h3>'
snippets['html']['h4'] = '<h4>%1</h4>'
snippets['html']['h5'] = '<h5>%1</h5>'
snippets['html']['h6'] = '<h6>%1</h6>'

snippets['html']['head'] = [[
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>%1</title>
  %2
</head>]]

snippets['html']['header'] = [[
<header>
  h1%1
</header>]]

snippets['html']['hr'] = '<hr>\n'

-- No <html> tag here - use `doc` snippet

-- No <i> tag here - use more semantically clear tags like <strong>

snippets['html']['iframe'] = '<iframe scr="%1" title="%2"></iframe>'

snippets['html']['img'] = '<img src="%1" alt="%2" width="%3" height="%4">'

-- Specific <inputs>
snippets['html']['input'] = '<input type="%1(text)" name="%2">'
snippets['html']['input-button'] = '<input type="button" value="%1">'
snippets['html']['input-checkbox'] = '<input type="checkbox" name="%1" value="%2">'
snippets['html']['input-color'] = '<input type="color" name="%1" value="#%2">'
snippets['html']['input-date'] = '<input type="date" name="%1">'
snippets['html']['input-datetime-local'] = '<input type="datetime-local" name="%1">'
snippets['html']['input-email'] = '<input type="email" name="%1">'
snippets['html']['input-file'] = '<input type="file" name="%1">'
snippets['html']['input-hidden'] = '<input type="hidden" name="%1" value="%2">'
snippets['html']['input-image'] = '<input type="image" src="%1" alt="%2" width="%3" height="%4">'
-- No `month` input here - no support in firefox
snippets['html']['input-number'] = '<input type="number" name="%1" min="%2" max="%3">'
snippets['html']['input-password'] = '<input type="password" name="%1">'
snippets['html']['input-radio'] = '<input type="radio" name="%1" value="%2">'
snippets['html']['input-range'] = '<input type="range" name="%1" min="%2" max="%3" value="%4">'
snippets['html']['input-reset'] = '<input type="reset">'
snippets['html']['input-search'] = '<input type="search" name="%1">'
snippets['html']['input-submit'] = '<input type="submit" value="%1">'
snippets['html']['input-tel'] = '<input type="tel" name="%1" pattern="%2(+[1-9]{1}-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2})" placeholder="%3(+X-XXX-XXX-XX-XX)">'
snippets['html']['input-text'] = '<input type="text" name="%1">'
snippets['html']['input-time'] = '<input type="time" name="%1">'
snippets['html']['input-url'] = '<input type="url" name="%1">'
-- No `week` input here - no support in firefox

snippets['html']['ins'] = '<ins>%1</ins>'

snippets['html']['kbd'] = '<kbd>%1</kbd>'

snippets['html']['label'] = '<label for="%1">%2</label>'

snippets['html']['legend'] = '<legend>%1</legend>'

snippets['html']['li'] = '<li>%1</li>'

snippets['html']['link'] = '<link rel="%1{alternate,author,dns-prefetch,help,icon,license,next,pingback,preconnect,prefetch,preload,prerender,prev,search,stylesheet}" href="%2">'

snippets['html']['main'] = [[
<main>
  %1
</main>]]

snippets['html']['map'] = [[
<img src="%1" width="%2" height="%3" alt="%4" usemap="#%5">
<map name="%5">
  area%6
</map>]]

snippets['html']['mark'] = '<mark>%1</mark>'

snippets['html']['meta'] = '<meta name="%1{application-name,author,description,generator,keywords,viewport}" content="%2">'

snippets['html']['meter'] = '<meter value="%1" min="%2" max="%3">%4</meter>'

snippets['html']['nav'] = [[
<nav>
  %1
</nav>]]

snippets['html']['noscript'] = '<noscript>%1(Your browser does not support JavaScript!)</noscript>'

snippets['html']['object'] = '<object data="%1" name="%2" width="%3" height="%4"></object>'

snippets['html']['ol'] = [[
<ol>
  li%1
</ol>]]

snippets['html']['optgroup'] = [[
<optgroup label="%1">
  option%2
</optgroup>]]

snippets['html']['option'] = '<option value="%1">%2</option>'

snippets['html']['output'] = '<output name="%1" for="%2"></output>'

snippets['html']['p'] = '<p>%1</p>'

snippets['html']['param'] = '<param name="%1" value="%2">'

snippets['html']['picture'] = [[
<picture>
  source-picture%1
  img
</picture>]]

snippets['html']['pre'] = [[
<pre>
%1
</pre>]]

snippets['html']['progress'] = '<progress value="%1" max="%2">%3</progress>'

snippets['html']['q'] = '<q>%1</q>'

snippets['html']['rp'] = '<rp>%1</rp>'
snippets['html']['rt'] = '<rt>%1</rt>'
snippets['html']['ruby'] = '<ruby>%1</ruby>'

snippets['html']['s'] = '<s>%1</s>'

snippets['html']['samp'] = '<samp>%1</samp>'

snippets['html']['script'] = '<script src="%1" type="application/javascript">%3</script>'

snippets['html']['section'] = [[
<section>
  %1
</section>]]

snippets['html']['select'] = [[
<select name="%1">
  option%1
</select>]]

snippets['html']['small'] = '<small>%1</small>'

snippets['html']['source-picture'] = '<source media="%1" srcset="%2">'
snippets['html']['source'] = '<source src="%1" type="%2">'

snippets['html']['span'] = '<span>%1</span>'

snippets['html']['strong'] = '<strong>%1</strong>'

snippets['html']['style'] = [[
<style>
  %1
</style>]]

snippets['html']['sub'] = '<sub>%1</sub>'

snippets['html']['summary'] = '<summary>%1</summary>'

snippets['html']['sup'] = '<sup>%1</sup>'

snippets['html']['svg'] = '<svg width="%1" height="%2"></svg>'

snippets['html']['table'] = [[
<table>
  thead%1

  tbody

  tfoot
</table>]]

snippets['html']['tbody'] = [[
<tbody>
  tr%1
</tbody>]]

snippets['html']['td'] = '<td>%1</td>'

snippets['html']['template'] = [[
<template>
  %1
</template>]]

snippets['html']['textarea'] = [[
<textarea name="%1" rows="%2" cols="%3">
</textarea>]]

snippets['html']['tfoot'] = [[
<tfoot>
  tr%1
</tfoot>]]

snippets['html']['th'] = '<th>%1</th>'

snippets['html']['thead'] = [[
<thead>
  tr_head%1
</thead>]]

snippets['html']['time'] = '<time datetime="%1">%2</time>'

-- No <title> tag here - use `doc` snippet

snippets['html']['tr'] = [[
<tr>
  td%1
</tr>]]

snippets['html']['tr_head'] = [[
<tr>
  th%1
</tr>]]

snippets['html']['track'] = '<track src="%1" kind="%2{captions,chapters,descriptions,metadata,subtitles}" srclang="%3" label="%4">'

-- No <u> tag here - use more span+CSS or semantically clear tags like <strong>

snippets['html']['ul'] = [[
<ul>
  li%1
</ul>]]

snippets['html']['var'] = '<var>%1</var>'

snippets['html']['video'] = [[
<video width="%1" height="%2" controls>
  source%3
  Your browser does not support the video tag.
</video>]]

snippets['html']['wbr'] = '<wbr>'
