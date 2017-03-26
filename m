From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] pwm: lpss: Add get_state callback
Date: Sun, 26 Mar 2017 15:34:52 +0300
Message-ID: <1490531692.708.5.camel@linux.intel.com>
References: <20170227165941.1379-1-hdegoede@redhat.com>
         <CAHp75Vdx4JNRzZSzfEe5H6Oj8vxJ7FJ-aA2ojY_HNgeXmCKq8A@mail.gmail.com>
         <8e7e2207-6004-13c3-1d6f-416bf306bc11@redhat.com>
         <1489160990.20145.192.camel@linux.intel.com>
         <29c21164-c5d7-3772-0bae-306780075ce6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61787 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdCZMe5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Mar 2017 08:34:57 -0400
In-Reply-To: <29c21164-c5d7-3772-0bae-306780075ce6@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andy@infradead.org>, linux-pwm@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Fri, 2017-03-10 at 22:13 +0100, Hans de Goede wrote:
> Hi,
> 
> On 03/10/2017 04:49 PM, Andy Shevchenko wrote:
> > On Tue, 2017-02-28 at 15:09 +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 27-02-17 23:20, Andy Shevchenko wrote:
> > > > On Mon, Feb 27, 2017 at 6:59 PM, Hans de Goede <hdegoede@redhat.
> > > > com>
> > > > wrote:

> > > Ok, so maybe we should do this then ?
> > > 
> > > 	if (freq == 0) {
> > > 		state->period = NSEC_PER_SEC;
> > > 		state->duty_cycle = NSEC_PER_SEC;
> > > 		return;
> > > 	}
> > > 
> > > ?
> > 
> > But the period is not that one. Can we assign them to 0?
> 
> That will cause a divide by 0 in apply() when a user
> calls apply without changing / setting period.

I have to look closer to this one. Perhaps next week together with yours
other change.

> > > Anyways since we now may get a pm-ref during probe
> > > I will add the balancing (and equally conditional)
> > > put of that ref to pwm_lpss_remove().
> > > 
> > > > Second question, how ->get_state() is supposed to work if power
> > > > is
> > > > off
> > > > when it enters it?
> > > 
> > > get_state only gets called on probe and the device is guaranteed
> > > to
> > > be powered on during probe().
> > 
> > Ah, seems I now understand what this call back actually does.
> > 
> > So, the name of the callback a bit confusing, to me it sounds rather
> > "get_to_[initial_]state()".
> > 
> > Thus, would it be better to split ->apply() to get a common part for
> > both?
> 
> I don't understand what you mean here ? Ah I guess you mean split
> out the pm_runtime_get / put stuff. I don't think that is going
> to work well as apply compares old and new state and we do not
> have old state when get_state gets called.

I mean to have similar flow in ->get_state() and ->apply() when we
enable the device.

I don't like ->get_state() name as I mentioned before. If its
functionality is "get *to* (initial) state", that what we need to
implement.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
