<%inherit file="_templates/site.mako" />

% for post in bf.config.blog.posts[:2]:
<%include file="post.mako" args="post=post" />
% endfor


