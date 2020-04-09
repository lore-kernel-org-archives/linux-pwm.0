From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v8 01/12] clk: pwm: Use 64-bit division function
Date: Wed, 8 Apr 2020 19:40:45 -0700
Message-ID: <20200409024045.GA1147@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <338966686a673c241905716c90049993e7bb7d6a.1583889178.git.gurus@codeaurora.org>
 <7506bc2972324fd286dac6327ec73a3a@AcuMS.aculab.com>
 <20200312020938.GA14827@codeaurora.org>
 <fea86a43b28f4493abe0826654369513@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26320 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgDICkq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Apr 2020 22:40:46 -0400
Content-Disposition: inline
In-Reply-To: <fea86a43b28f4493abe0826654369513@AcuMS.aculab.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>

On Thu, Mar 12, 2020 at 09:14:09AM +0000, David Laight wrote:
> From: Guru Das Srinagesh
> > Sent: 12 March 2020 02:10
> > On Wed, Mar 11, 2020 at 04:58:24PM +0000, David Laight wrote:
> > > From: Guru Das Srinagesh
> > > > Sent: 11 March 2020 01:41
> > > >
> > > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > > to u64, prepare for this transition by using div64_u64 to handle a
> > > > 64-bit divisor.
> > > >
> ...
> > > > --- a/drivers/clk/clk-pwm.c
> > > > +++ b/drivers/clk/clk-pwm.c
> > > > @@ -89,7 +89,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
> > > >  	}
> > > >
> > > >  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> > > > -		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> > > > +		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
> > >
> > > That cannot be needed, a 32 bit division is fine.
> > 
> > Could you please explain why? I think the use of this function is
> > warranted in order to handle the division properly with a 64-bit
> > divisor.
> ...
> > > I'd assign pargs.period to an 'unsigned int' variable
> > > prior to the division (I hate casts - been bitten by them in the past.).
> > 
> > Wouldn't this truncate the 64-bit value? The intention behind this patch
> > is to allow the processing of 64-bit values in full.
> 
> You are dividing a 32bit constant by a value.
> If pargs.period is greater than 2^32 the result is zero.

Correction: if pargs.period is greater than NSEC_PER_SEC, not 2^32.

> I think you divide by 'fixed_rate' a bit later on - better not be zero.

I am adding an explicit check in v12 to ensure fixed_rate is not zero. If
during the calculation it is found to be zero, probing will fail.

I think with this modification, this v8 version of this change makes
sense to use.

Thank you.

Guru Das.
