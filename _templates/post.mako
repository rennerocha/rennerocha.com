<%page args="post"/>
<%
    category_links = []
    for category in post.categories:
        if post.draft:
            #For drafts, we don't write to the category dirs, so just write the categories as text
            category_links.append(category.name)
        else:
            category_links.append("<a href='%s'>%s</a>" % (category.path, category.name))
%>

<a name="${post.slug}"></a>
<h3><a href="${post.permapath()}">${post.title}</a></h3>
<p class="post_date"><span style="margin-left: 0px;">${post.date.strftime("%d-%m-%Y - %I:%M %p")}</span> &#8226; <span>${", ".join(category_links)}</span></p> 

<div class="post_prose">
  ${self.post_prose(post)}
</div>

<hr/>
<div id="disqus_thread"></div>
<script type="text/javascript">
    var disqus_shortname = 'rennerocha';
    var disqus_url = 'http://rennerocha.com';
    var disqus_identifier = "${post.permalink}";
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>

<%def name="post_prose(post)">
  ${post.content}
</%def>
