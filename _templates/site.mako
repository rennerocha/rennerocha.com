<%inherit file="base.mako" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    ${self.head()}
  </head>
  <body>
    <div id="content" class="container_16">
      <div id="sidebar" class="grid_4">
        ${self.sidebar()}
      </div> <!-- End Sidebar -->
      <div id="main_block" class="grid_12">
        ${next.body()}
      </div><!-- End Main Block -->
    </div> <!-- End Content -->
  </body>
</html>
<%def name="head()">
  <%include file="head.mako" />
</%def>
<%def name="sidebar()">
  <%include file="sidebar.mako" />
</%def>
