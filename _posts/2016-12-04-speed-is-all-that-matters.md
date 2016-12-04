---
layout: post
categories: [code, musing]
---

> If you find that you're spending almost all your time on theory, start turning some attention to practical things; it will improve your theories. If you find that you're spending almost all your time on practice, start turning some attention to theoretical things; it will improve your practice. - Donal Knuth

I have an addiction to infrastructure. While programing a solution, I eventually find that I am working on things that do not directly contribute to solving the problem. From a rational/detached/post-fact perspective, I know that this is a huge source of waste. Funny, I never seem to notice this at the time.

## The Problem

I **do not** have a problem with motivation. If anything, I do not value my time as much as I should. Let us leave that for another rant. 

I **do not** have a problem with my programming skill set. It isn't lack of skill that impedes my ability to deliver. Not to say that I have nothing that needs improvement. My mathematics is weak, I never really got SQL, my Git skill are passable but nothing extroardinary, I am average at using the terminal, I type poorly, etc... There are a huge number of things I could learn and improve on, but non of those things stop me from being able to build solutions.

I **do** spend an embarassing amount of time trying to get things perfect. 

I **do** spend far too much energy trying to deal with eventualities that never emerge. 

I **do** spend mental focus on vanity features that I hope to someday reveal to the world, blinding it with my genius. 

Meanwhile, the actual business problem sits untouched.


## Observations

Speed is king. I am beginning to believe that this may be true of most things in life. I think the shortest way to get good at something is to become skilled enough to do it quickly. This seems to be true for artist and craftmen, so why shouldn't it be true for programmers?

It seems to me that there are at least 3 elements to speed.

### Concurrency
Getting seperate works to come together harmoniously. This is one of the main differences between a good cook and a chef. A good cook often does one thing at a time in a linear fashion. A chef is often doing 3 or 4 things concurrently, connecting them so that they are all completed at the right moment.

Actual context switching in programming is almost certainly a detriment. However, the ability to know the order that things need to be acomplished to minimize downtime is a real skill. Huge numbers of books have been written on software estimation. I am not going to say anything about that. I am going to say that if you have done a task 10 times and it took an average of 15 minutes, then you can probably estimate that the 11th time will take around 15 minutes. This means that you can probably fit this task in a 20 minute lull in your schedule. This makes you faster.

### Context Switch (Economy of Motion)
People who have speed aren't always fast. Sometimes they are just more efficient. A good example of this is beginner vs advanced guitarist. Beginner guitarist almost always move significantly more than needed to pick a note. An advanced guitarist does a minimal move. Guess who is going to pick faster (as well as tire more slowly)?

A large part of context switching in programming is familiarizing yourself with the codebase. If you are reusing a codebase that you have previously used, you can dramatically reduce the context switch of familiarizing yourself. This makes you faster.

### Actions Per Minute
A measure of the number of task you can perform per unit time. This mostly has to do with repetition. You can perform a task more quickly if you have done a similar task in recent memory. Examples of this are evident.

Programmers may relate to this through the notion of Flow. When you don't have to stop and question how to do something, but can focus simply on what you are doing. This makes you faster as well as less succeptible to distraction.

## Solution

Simple. Don't work on the big until you can quickly do the small. That is all I got.

*Note: I am picturing a small project being ~10 hours. A medium project being ~50 hours. A large project being 200+ hours.*

1. Write down the project name, the difficulty, and the due date given your alloted time. Leave a small space for &#x2713; or &#x2717;.
2.  If you succeed at finishing the project within time, give yourself a &#x2713; next to the project, otherwise give yourself an &#x2717;. Either way, close the project.
3. Now, ask yourself what the hardest difficulties were. Pick one of these difficulties to fix with infrastructure.
4. Give yourself as much time to write the infrastructure as you spent on the last project. If you fail to get the infrastructure working within time, then stop and go to the next project. This is fine, our goal is to increase speed mostly through your own personal velocity, not through infrastructure.
5. Pick the next Project. If the last 3 consecutive projects with &#x2713; next to them are of the same difficulty, feel free to move to a higher difficulty project. Loop back to step 1.


### Speed
I think it is pretty natural to pick similar projects. Especially if you are trying to get "faster". This should really allow you to focus on increasing speed (specifically through Actions Per Minute).

### Scratching that Infrastructure Itch
Step 3 & 4 are designed to allow you to address persistent difficulties in code by writting infrastructure. This is very different than my current method of writting infrastructure though as:

1. These are problems that actually came up in the project (no guesswork here).
2. I am limiting how long I can spend on each piece of infrastructure.
3. I am limiting myself to working on only 1 piece of infrastructure.
4. I am stopping infrastructure work if it exceeds its allocated time. Distance lets me become more level headed about whether it is a worthwhile investments. I can choose to resume after another project, but I may decide they it was a false paths. The forced break gives me time for reflection.
5. Note that at most you are spending 50% of your time on infrastructure. I don't know what the right number for that would be, but it is certainly better than I have done on personal projects in the past.

### Confidence
Although not mentioned until here. I think that being able to do something quickly and well dramatically increases confidence. Computers don't care about confidence, but humans do. If you are reading this you are likely human and as such should look after your mental well being. Being confident in a skill you have could open a lot of doors...
