---
layout: post
title:  Pagination on Google App Engine Standard
categories: [code]
---

Datastore (Google App Engine) does not let you lock the database. So how do you map across every element in Datastore? Here is a very rough and tumble solution to that problem.

### Usage
*Assume you have a `ndb.Model` named `Widget`*

Begin pagination using the following (note that `Widget` is case sensitive)
```
curl https://example-domain.appspot.com/paginate/Widget
# => {'keys': [<URLSAFEKEYS>], 'cursor': <CURSOR_VALUE>}`.
```
Use `<CURSOR_VALUE>` to continue pagination across all `Widget`'s
```
curl https://example-domain.appspot.com/paginate/Widget/<CURSOR_VALUE>
``` 

### Code
<script src="https://gist.github.com/samedhi/ac371892a21bea6fc1f13025320f911f.js"></script>
