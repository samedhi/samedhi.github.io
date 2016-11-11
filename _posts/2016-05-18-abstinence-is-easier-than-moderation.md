---
layout: post
categories: [lifehacks, code]
---

I don't own a television. That is no boast, it is a reflection of my poor taste.  I am the sort of person that will watch things because they are on. If I owned a television, I would likely spend my days going from Judge Judy to Jerry Springer and back.

I am just as bad at impulse control on the internet. I need a computer to do most... well... everything. For some parts of my day, I need to be working. For others, it is time to sit back, relax, and browse.

I edited my `/etc/hosts` file so that it redirects sites that are time sinks to localhost. I get a nice `This site can’t be reached`; no more visiting reddit 3 times an hour!

Sometimes though, I want to actually relax and browse. I then need to edit `/etc/hosts` again to unblock all those performance killing sites.

Having to edit a file on a daily basis is painful. I can do better.

I am on a Mac, so I use [launchd](http://launchd.info/) to create two scripts that run at 22:00 and 2:00. The 2:00 script returns my computer to the "focused" state, limiting what sites I can visit. The 22:00 script puts my computer in a "relaxed" state, allowing me to browse until bedtime. Both of these files should be in your `/Library/LaunchDaemons` directory. The advantage of putting these files in `/Library/LaunchDaemons` as opposed to `~/Library/LaunchAgents` is that they are run whenever the computer is on, rather than just when you are logged in. Also, they will run upon wake, even if the trigger time occured while the computer was asleep.

[Daemonic Agents - Code example that includes /etc.hosts files that I find useful](https://github.com/samedhi/daemonic-agents)
