<%inherit file="_templates/site.mako" />

% for post in bf.config.blog.posts[:1]:
<%include file="post.mako" args="post=post" />
% endfor


<hr/>
<p>Outros artigos</p>
<ul>
% for post in bf.config.blog.posts[:5]:
    <li><a href="${post.path}">${post.title}</a></li>
% endfor
</ul>
