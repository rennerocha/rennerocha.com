<%inherit file="_templates/site.mako" />
<h1>Arquivo</h1>

<div id="arquivo">
    <ul>
    % for post in bf.config.blog.posts:
        <li><a href="${post.permapath()}">${post.title}</a><br/>
        ${post.date.strftime("%d-%m-%Y - %I:%M %p")}
        </li>
    % endfor
    </ul>
</div>
