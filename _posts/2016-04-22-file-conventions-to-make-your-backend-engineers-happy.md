---
layout: post
categories: [code]
---

A random list of file conventions that make me happy. Although these do not apply to every situation, they are true enough that you should at least consider them when creating an output file format.

## If it is a list of things, use CSV

Don't make up your own format. Please. Just use CSV (note: does not have to be commas, any unused delimiter will work, or use quoting characters within your CSV if you have to).

## Don't use slashes in the filename

This hurts. If you include slashes in the filename, it makes is look like the file is actually a directory listing. Furthermore, modern storage system like gcs and s3 don't really have directories (they are really just a bunch of objects in a bucket). However, they will logically present these objects as if they are made up of directories if you include slashes in the names. This is odd because when you download individual files they will download as files. When you view them the files within the s3 viewer they will appear as directories. when you (r)sync the buckets the files  they will appear as directories... It just gets messy. Just don't use directories. Use a flat bucket of files.

## Include everything of a homogenous type within a single directory/bucket

I think buckets should basically be treated like typed arrays/vectors/list. You should only have a single type of thing within them. Don't mix multiple different types of things as you are then forcing someone using said bucket to filter on what they need. Really, if you have multiple types of things, use multiple buckets.

## Make it so the names of files are automatically sorted in some usefull way

Let me provide an example.

```
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/89/0/rtp.pcap.wav.ctm
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/9/0/rtp.pcap.wav.ctm
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/90/0/rtp.pcap.wav.ctm
```

`9` should not logically be between `89` and `90`. However, most directory listing operations will list things according to logical text order. Ugly. I think it it would be much better to sufficiently pad such a file so that `9` does not show up here, something like

```
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/00008/0/rtp.pcap.wav.ctm
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/00009/0/rtp.pcap.wav.ctm
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/00010/0/rtp.pcap.wav.ctm
...
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/00089/0/rtp.pcap.wav.ctm
1946304563_66189429@216.221.154.11-66.228.112.5:27832/callee/00090/0/rtp.pcap.wav.ctm
```

Of course, this involves either:

1. Just picking some arbitrary padding that will always be sufficient (famous last words)
2. Extending the padding on all previous files whenever you add another digit. So, for instance, when you are on element `10` you go through all previously written files and change `0` to `00`, `1` to `01`, `2` to `02`, etc.

*Let me just say how much I appreciate you doing this for me. You have no idea how anoying it is to have to always* `itertools.groupby(sorted(os.listdir(path), key=key_fx1), key=key_fx2)` *whenever your filenames does not logically sort. Tiresome.*
