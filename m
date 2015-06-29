From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v4 2/2] pwm: Add support for R-Car PWM Timer
Date: Mon, 29 Jun 2015 09:49:47 +0000
Message-ID: <SG2PR06MB0919623D7D1E90DE9D3E811BD8AA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1432205846-4312-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150612120600.GM19400@ulmo.nvidia.com>
 <SG2PR06MB09195A961FECE276F001493AD8B80@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <20150629091215.GE5431@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150629091215.GE5431@ulmo>
Content-Language: ja-JP
Sender: linux-sh-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

> Sent: Monday, June 29, 2015 6:12 PM
> 
> On Mon, Jun 15, 2015 at 05:48:00AM +0000, Yoshihiro Shimoda wrote:
> [...]
> > > > +static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div,
> > > > +				 int duty_ns, int period_ns)
> > > > +{
> > > > +	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
> > > > +	unsigned long clk_rate = clk_get_rate(rp->clk);
> > > > +	u32 cyc, ph;
> > > > +
> > > > +	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
> > > > +	do_div(one_cycle, clk_rate);
> > > > +
> > > > +	tmp = period_ns * 100ULL;
> > > > +	do_div(tmp, one_cycle);
> > > > +	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
> > > > +
> > > > +	tmp = duty_ns * 100ULL;
> > > > +	do_div(tmp, one_cycle);
> > > > +	ph = tmp & RCAR_PWMCNT_PH0_MASK;
> > > > +
> > > > +	/* Avoid prohibited setting */
> > > > +	if (cyc && ph)
> > > > +		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> > >
> > > So if a period and duty-cycle are passed in that yield the prohibited
> > > setting the operation will simply be silently ignored?
> >
> > Yes, to update values of pwm->duty_cycle and ->period by pwm_config(),
> > this code will be silently ignored.
> 
> That's not right. If someone passes in invalid values you should report
> an error.

Thank you for the comment.
After I sent the previous email, I was also confusing this behavior.
So, I fixed it in v5 patch.
(In other words, if the PWM is enabled and a user input invalid values,
 this driver will report an error.)

I'm sorry, I should have explained that in this email thread.

> Also, are you sure the check is correct? The current check:
> 
> 	if (cyc && ph)
> 
> is the same as
> 
> 	if (cyc != 0 && ph != 0)
> 
> which means that you will never be able to set a zero duty cycle. Is
> that really what you want here?

Yes, I really want to avoid to set a zero duty cycle because
the PWM doesn't accept it.
(According to the datasheet, it said "Setting H'000 is prohibited.")

Best regards,
Yoshihiro Shimoda

> Thierry
