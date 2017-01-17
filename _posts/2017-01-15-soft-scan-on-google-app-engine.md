---
layout: post
categories: [code]
---

[Google App Engine](https://cloud.google.com/appengine/) does not allow for a [SCAN](https://en.wikipedia.org/wiki/Full_table_scan) like operation on a table. Although this is a hard limit, it can be worked around with some thought. This is my generic solution.

## Considerations
GAE does not allow locking of the database, it is impossible to guarantees processing on every row in a table. The closest GAE can come to a scan is a query; an iterator really. Queries are "best effort" and are not guaranteed to reflect the current state of the database. Still, they are the best you have.

Using a iterator would be a O(N) cost, where N is the number of rows in a table. GAE is all about scaling dynamically. It would be nice if we could divide up the work of processing every row in the table.

## Solution
I have written a system that lets you (probabilistically) process every element in a table. It does not guarantee that every element has been processed, but with a sufficient number of retries it is likely that you have covered everything.

## Usage

```
scan(
  '<kind>', # the Datastore kind that you want to scan
  '<handler-path>', # a path that will be called (see below)
  retries=1, # a non negative integer, default 1
  retry-fx=lambda i: i**2, # i is the retry count, i=0 is always immediate
  max-retries=2, # a non negative integer, default 2
)
```

The `handler-path` will be called with the `urlsafe()` key of every entity of `'kind'` `<kind>`. Specifically `/<handler-path>/<urlsafekey>` will be called for every `<kind>` entity. If `handler-path` returns 2xx, it is considered a success; otherwise it is a failure. Failure will cause the task to be re-enqueued in `retry-fx(retry-count)` seconds.

## How
