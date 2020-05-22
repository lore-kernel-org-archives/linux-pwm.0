From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Fri, 22 May 2020 12:31:47 +0100
Message-ID: <20200522113147.GU271301@dell>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
 <20200522111657.GA2163848@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgEVLbv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 07:31:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD0C05BD43
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 04:31:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so9783563wre.13
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 04:31:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200522111657.GA2163848@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Thompson <daniel.thompson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>

On Fri, 22 May 2020, Thierry Reding wrote:

> On Thu, May 21, 2020 at 08:15:05AM +0100, Lee Jones wrote:
> > On Wed, 20 May 2020, Guru Das Srinagesh wrote:
> > 
> > > On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > > > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > > > 
> > > > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > > > A great deal of mailing lists contain numerous protections against
> > > > > > things like flooding and spamming.  One of those protections is a
> > > > > > check for "Too many recipients to the message".  Most of the time this
> > > > > > simply requires moderator intervention by way of review and approval,
> > > > > > but this ultimately depends on the ML's configuration.
> > > > > > 
> > > > > > The first thing to ascertain is why your recipients list is so large.
> > > > > > Have you added every reviewer, subsystem-maintainer, maintainer and
> > > > > > contributor suggested by get-maintainer.pl?  If so, consider pruning
> > > > > > that a little.  Contributors do not tend to care about subsequent
> > > > > > changes to a file.  As someone who receives a lot of patches, I tend
> > > > > > to get fed-up when receiving patches simply because I made a change X
> > > > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > > > instance and see how far that takes you.
> > > > > 
> > > > > Thank you for the detailed reply. I did this in the first few patchsets
> > > > > and then when a few patches didn't get any attention, expanded the
> > > > > audience thus. Still, around 50% of the patches in this series remain
> > > > > unreviewed by anyone.
> > > > 
> > > > This isn't a reason to add more recipients (who are likely to care
> > > > even less than your original group).  However it *is* a good argument
> > > > for including all of the specified maintainers/reviewers in on all of
> > > > the patches.
> > > > 
> > > > > > If your recipients list is as succinct as reasonably possible, maybe
> > > > > > just accept that every version isn't going to be archived by every
> > > > > > ML.  It's still much more useful for the correct people to have
> > > > > > visibility into the set than for it to be archived multiple times.
> > > > > 
> > > > > Thank you, will prune the list and remove past contributors from the
> > > > > Cc-list and add all parties to all patches.
> > > > 
> > > > Great.  Once you've done that, we can start to help you acquire the
> > > > Acks you need on your remaining patches.
> > > 
> > > Hi Lee, Thierry, Uwe,
> > > 
> > > In v14 of this patchset I've pruned the list of contributors, removed
> > > past contributors from the cc-list, and added all parties to all patches
> > > (except for the patches that are yet to reviewed, for which I've added
> > > what get_maintainer.pl showed me). I've also resent v14 a couple of
> > > times already, with around a week's time interval between resends, and
> > > somehow it seems like this set has lost traction.
> > > 
> > > Could you please indicate what next steps I should take to have more
> > > eyes on the unreviewed patches? Only 4 out of 11 patches remain
> > > unreviewed.
> > 
> > Looks like we're waiting on Thierry (again).
> > 
> > This has been a common theme over the past few months.
> > 
> > Perhaps he has changed employer/project?
> 
> My work on PWM is purely done in my spare time. I don't get paid for any
> of it. I currently have two kids that need home-schooling, as many
> others probably do, and I have a full time job doing non-PWM related
> things. As a result my spare time is close to nil these days.

This is no different to many others.  I too am not paid for this work,
but it's still my responsibly to ensure a reply within a reasonable
amount of time.

We can all appreciate that the latest situation has exacerbated issues,
but a reasonable level of PWM participation, blocking various
patch-sets has been lacking for months before we'd even heard of
Covid-19 [0].

If you need help, just ask for it.  I am willing to step up and review
patches if you're overloaded.  Uwe is already listed as a designated
reviewer.  Perhaps between the 3 of us we can work something out in
order to reduce the latency.

[0] https://patchwork.ozlabs.org/project/linux-pwm/list/

> I very much appreciate all the effort that others have spent in getting
> this reviewed. I haven't been able to keep a very close eye on this, but
> even the latest versions have some comments, so I didn't consider this
> ready yet. If that's changed and everybody's okay with the changes, then
> I can apply this to for-next. We haven't got all that much time left
> before the merge window and I had hoped this would be ready earlier so
> that we'd have more time for this in linux-next. But I'd be willing to
> at least give it a try. If it starts to look like there are going to be
> issues with this I can always back them out and we can have another go
> next release.

If you would be so kind as to review the PWM patches, I can take them
in but I can't do anything without your Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
