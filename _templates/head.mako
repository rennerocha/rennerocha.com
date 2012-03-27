
    <meta charset="utf-8">
    <title>${bf.config.blog.name}</title>
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:300,400,700' rel='stylesheet' type='text/css'>
    <link rel='stylesheet' href='/media/css/base.css' type='text/css' />

    <!-- RSS links -->
    <link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="${bf.util.site_path_helper(bf.config.blog.path,'/feed')}" />
    <link rel="alternate" type="application/atom+xml" title="Atom 1.0" href="${bf.util.site_path_helper(bf.config.blog.path,'/feed/atom')}" />

    <!-- Syntax Highlight -->
    <link rel='stylesheet' href='${bf.config.filters.syntax_highlight.css_dir}/pygments_${bf.config.filters.syntax_highlight.style}.css' type='text/css' />

