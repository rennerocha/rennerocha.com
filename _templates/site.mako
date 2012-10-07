<%inherit file="base.mako" />
<!DOCTYPE html>
<html lang="pt">
  <head>${self.head()}</head>

  <body>
    <div class="container">

      <div class="row">
        <div class="span9">
          <h1>Renne Rocha</h1><hr>
        </div>
      </div>
      
      <div class="row" id="header">
        <div class="span7">
          ${next.body()}
        </div>

        <div class="span2">
          <ul class="nav nav-pills nav-stacked">
            <li><a href="/">In&iacute;cio</a></li>
            <li><a href="/arquivo">Arquivo</a></li>
            <li><a href="/sobre">Sobre</a></li>
            <li><a href="https://github.com/rennerocha">Projetos</a></li>
            <li><a href="http://twitter.com/rennerocha">Twitter</a></li>
            <li><a href="/feed/index.xml">RSS</a></li>
          </ul>

          <div style="margin-top:50px;"> 
<script type="text/javascript"><!--
amazon_ad_tag = "rennerochacom-20"; amazon_ad_width = "120"; amazon_ad_height = "240";//--></script>
<script type="text/javascript" src="http://www.assoc-amazon.com/s/ads.js"></script>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="span9">
          <small>Este blog est&aacute; hospedado na <a href="http://www.webfaction.com?affiliate=rennerocha">WebFaction</a>.</small>
      </div>

    </div>
  </body>
</html>

<%def name="head()">
  <%include file="head.mako" />
</%def>
