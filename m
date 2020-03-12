From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v8 01/12] clk: pwm: Use 64-bit division function
Date: Wed, 11 Mar 2020 19:09:40 -0700
Message-ID: <20200312020938.GA14827@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <338966686a673c241905716c90049993e7bb7d6a.1583889178.git.gurus@codeaurora.org>
 <7506bc2972324fd286dac6327ec73a3a@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7506bc2972324fd286dac6327ec73a3a@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 11, 2020 at 04:58:24PM +0000, David Laight wrote:
> From: Guru Das Srinagesh
> > Sent: 11 March 2020 01:41
> > 
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by using div64_u64 to handle a
> > 64-bit divisor.
> > 
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/clk/clk-pwm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > index 87fe0b0e..7b1f7a0 100644
> > --- a/drivers/clk/clk-pwm.c
> > +++ b/drivers/clk/clk-pwm.c
> > @@ -89,7 +89,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
> >  	}
> > 
> >  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> > -		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> > +		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
> 
> That cannot be needed, a 32 bit division is fine.

Could you please explain why? I think the use of this function is
warranted in order to handle the division properly with a 64-bit
divisor.

> More interesting would be whether pargs.period is sane (eg not zero).

There is a non-zero check for pargs.period just prior to this line, so
the code is handling this case already.

> I'd assign pargs.period to an 'unsigned int' variable
> prior to the division (I hate casts - been bitten by them in the past.).

Wouldn't this truncate the 64-bit value? The intention behind this patch
is to allow the processing of 64-bit values in full.

Thank you.

Guru Das.
