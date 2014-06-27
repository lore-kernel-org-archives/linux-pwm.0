From: Johannes Pointner <johannes.pointner@gmail.com>
Subject: Re: [PATCH] Added possibility to use pwm_bl.c with percentage instead
 of levels
Date: Fri, 27 Jun 2014 10:17:50 +0200
Message-ID: <CAJKbBDDE5scMucQ=dOxi0bcbKT6nmN18zCs1JczS2zA9PC6aBQ@mail.gmail.com>
References: <CAJKbBDD1SANFaXqKnxEAOdLH=s+Jo1b2bXKeebCfV--PhZUScQ@mail.gmail.com>
	<20140627061231.GD9258@ulmo>
	<CAJKbBDDS1Dfpsv8C4W_2uBEgYpO2FmYyMHrZ9vAy_k_jTdV5MA@mail.gmail.com>
	<20140627070902.GA10703@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:49253 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbaF0IRv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Jun 2014 04:17:51 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so4134830qgd.10
        for <linux-pwm@vger.kernel.org>; Fri, 27 Jun 2014 01:17:51 -0700 (PDT)
In-Reply-To: <20140627070902.GA10703@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>

2014-06-27 9:09 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Fri, Jun 27, 2014 at 08:58:21AM +0200, Johannes Pointner wrote:
>> I know what you mean because I have here for example a panel that only
>> supports a duty cycle between 20 and 100 percent. But wouldn't I be a
>> possibility to add optional nodes with minimal/maximal brightness or
>> something like that?
>
> We have something like that (lth_brightness) for non-DT and which was
> supported in the first DT proposals. But again the equivalent using the
> brightness-levels would be:
>
>         brightness-levels = <0 20 21 ... 100>;

You are right this would be a possibility but I thought that
configuring such ranges is much more readable than really writing it
down.

>
> So the continuous range and low threshold are really just special cases
> of what brightness-levels provides. Granted, it's somewhat tedious to
> have to list ~100 values in a DT property like this, but I haven't
> really heard any arguments why the range really needs to be that
> fine-grained. Most of the devices that I've used have somewhere between
> 8 and 20 brightness levels. An exception to this are Android devices,
> which do indeed seem to support truly continuous ranges.

In my case the fine granularity is demanded by our customers ( they
are all used to desktop monitors where they can freely adjust the
brightness even they don't really need that) and I have to make that
somehow possible. But I understand your concerns.

Hannes

>
> Thierry
>
>>
>> Hannes
>>
>>
>> 2014-06-27 8:12 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
>>
>> > On Fri, Jun 27, 2014 at 07:32:20AM +0200, Johannes Pointner wrote:
>> > > Hello,
>> > >
>> > > I'm new working on the linux device drivers, so if I made something wrong
>> > > please point me into the right direction.
>> > >
>> > > I'd like to use the pwm_bl driver for a sitara based terminal and for
>> > this
>> > > I would need the possibility to set the backlight within a percentage
>> > > range. The following patch should add this possibility to the pwm_bl
>> > > driver. The idea is to keep backward compatibility by moving the required
>> > > option brightness levels to optional. Therefore if there is no node with
>> > > brightness levels the percentage levels are used.
>> > >
>> > > Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
>> > > ---
>> > >  .../bindings/video/backlight/
>> > > pwm-backlight.txt     | 11 +++---
>> > >  drivers/video/backlight/pwm_bl.c                   | 46
>> > > ++++++++++++----------
>> > >  2 files changed, 31 insertions(+), 26 deletions(-)
>> >
>> > Also adding the backlight maintainers on Cc.
>> >
>> > This has been discussed a few times before. In fact the original device
>> > tree binding had support for a continuous range of levels but that was
>> > rejected during review. The reason was, as far as I remember, that the
>> > number of levels and the corresponding duty cycle values is something
>> > that's usually determined at system design time. Often backlights can't
>> > properly light the whole surface of the panel at every level.
>> >
>> > That said, there's always the possibility to fake this by adding a DT
>> > property with a continuous range, such as this:
>> >
>> >         brightness-levels = <0 1 2 ... 100>;
>> >
>> > Thierry
>> >
