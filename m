From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] pwm: lpss: Add get_state callback
Date: Fri, 10 Mar 2017 17:49:50 +0200
Message-ID: <1489160990.20145.192.camel@linux.intel.com>
References: <20170227165941.1379-1-hdegoede@redhat.com>
         <CAHp75Vdx4JNRzZSzfEe5H6Oj8vxJ7FJ-aA2ojY_HNgeXmCKq8A@mail.gmail.com>
         <8e7e2207-6004-13c3-1d6f-416bf306bc11@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22048 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdCJPtz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 10 Mar 2017 10:49:55 -0500
In-Reply-To: <8e7e2207-6004-13c3-1d6f-416bf306bc11@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andy@infradead.org>, linux-pwm@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Tue, 2017-02-28 at 15:09 +0100, Hans de Goede wrote:
> Hi,
> 
> On 27-02-17 23:20, Andy Shevchenko wrote:
> > On Mon, Feb 27, 2017 at 6:59 PM, Hans de Goede <hdegoede@redhat.com>
> > wrote:

> > > +       base_unit_range = BIT(lpwm->info->base_unit_bits);
> > > +
> > > +       ctrl = pwm_lpss_read(pwm);
> > > +       on_time_div = 255 - (ctrl & PWM_ON_TIME_DIV_MASK);
> > > +       base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) &
> > > (base_unit_range - 1);
> > > +
> > > +       freq = base_unit * lpwm->info->clk_rate;
> > > +       do_div(freq, base_unit_range);
> > > +       if (freq == 0)
> > > +               state->period = NSEC_PER_SEC;
> > 
> > And this is wrong. IIRC base_unit = 0 *or* on_time_div = 255 means
> > duty cycle = 100%.
> 
> Ok, so maybe we should do this then ?
> 
> 	if (freq == 0) {
> 		state->period = NSEC_PER_SEC;
> 		state->duty_cycle = NSEC_PER_SEC;
> 		return;
> 	}
> 
> ?

But the period is not that one. Can we assign them to 0?

> > > +       else
> > > +               state->period = NSEC_PER_SEC / (unsigned
> > > long)freq;
> > 
> > I would stop doing versions so fast and give one more try with
> > carefully chosen variable types and perhaps a bit straighter
> > arithmetic here.
> 
> I've carefully chosen the variable types, freq needs to
> be 64 bits for do_div usage. Here I'm going from
> freq (which has been divided by now) to a period time
> in nsec, for which:
> 
> 	state->period = NSEC_PER_SEC / (unsigned long)freq;
> 
> Is as straight forward as one can get, the
> (unsigned long) cast is there to force a 32 bit
> division since freq is known to fit in 32 bits at this
> time.

OK!

> 
> > > +
> > > +       on_time_div *= state->period;
> > > +       do_div(on_time_div, 255);
> > > +       state->duty_cycle = on_time_div;
> > > +
> > > +       state->polarity = PWM_POLARITY_NORMAL;
> > > +       state->enabled = !!(ctrl & PWM_ENABLE);
> > > +
> > > +       if (state->enabled)
> > > +               pm_runtime_get_sync(chip->dev);
> > 
> > Since you are too fast (again), let me ask where is the balanced put
> > for this call?
> 
> As I explained in my earlier mail this is balanced
> by the disable path in apply(). But I guess what you are
> getting at is what if the driver gets removed while the
> pwm is enabled? It seems that we then indeed leak our
> runtime-pm ref, note that is a pre-existing bug.

I see.

> Anyways since we now may get a pm-ref during probe
> I will add the balancing (and equally conditional)
> put of that ref to pwm_lpss_remove().
> 
> > Second question, how ->get_state() is supposed to work if power is
> > off
> > when it enters it?
> 
> get_state only gets called on probe and the device is guaranteed to
> be powered on during probe().

Ah, seems I now understand what this call back actually does.

So, the name of the callback a bit confusing, to me it sounds rather
"get_to_[initial_]state()".

Thus, would it be better to split ->apply() to get a common part for
both?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
