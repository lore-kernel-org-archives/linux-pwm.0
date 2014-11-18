From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: add at91sam9x5 and sama5d3 errata
 handling
Date: Tue, 18 Nov 2014 16:53:33 +0100
Message-ID: <20141118165333.6d9ff951@bbrezillon>
References: <1416314453-28597-1-git-send-email-boris.brezillon@free-electrons.com>
	<20141118150016.GB18586@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59743 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753943AbaKRPxh (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 10:53:37 -0500
In-Reply-To: <20141118150016.GB18586@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>

Hi Thierry,

On Tue, 18 Nov 2014 16:00:23 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Nov 18, 2014 at 01:40:53PM +0100, Boris Brezillon wrote:
> > at91sam9x5 has an errata forbidding the use of slow clk as a clk source and
> > sama5d3 SoCs has another errata forbidding the use of div1 prescaler.
> > 
> > Take both of these erratas into account.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/pwm/pwm-atmel-hlcdc.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> > index eaf8b12..405f8a5 100644
> > --- a/drivers/pwm/pwm-atmel-hlcdc.c
> > +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> > @@ -36,6 +36,8 @@ struct atmel_hlcdc_pwm {
> >  	struct pwm_chip chip;
> >  	struct atmel_hlcdc *hlcdc;
> >  	struct clk *cur_clk;
> > +	bool slow_clk_errata;
> > +	bool div1_clk_errata;
> >  };
> >  
> >  static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
> > @@ -56,20 +58,28 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
> >  	u32 pwmcfg;
> >  	int pres;
> >  
> > -	clk_freq = clk_get_rate(new_clk);
> > -	clk_period_ns = (u64)NSEC_PER_SEC * 256;
> > -	do_div(clk_period_ns, clk_freq);
> > +	if (!chip->slow_clk_errata) {
> > +		clk_freq = clk_get_rate(new_clk);
> > +		clk_period_ns = (u64)NSEC_PER_SEC * 256;
> > +		do_div(clk_period_ns, clk_freq);
> > +	}
> >  
> > -	if (clk_period_ns > period_ns) {
> > +	/* Errata: cannot use slow clk on some IP revisions */
> > +	if (chip->slow_clk_errata || clk_period_ns > period_ns) {
> >  		new_clk = hlcdc->sys_clk;
> >  		clk_freq = clk_get_rate(new_clk);
> >  		clk_period_ns = (u64)NSEC_PER_SEC * 256;
> >  		do_div(clk_period_ns, clk_freq);
> >  	}
> >  
> > -	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++)
> > +	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
> > +		/* Errata: cannot divide by 1 on some IP revisions */
> > +		if (!pres && chip->div1_clk_errata)
> > +			continue;
> > +
> >  		if ((clk_period_ns << pres) >= period_ns)
> >  			break;
> > +	}
> >  
> >  	if (pres > ATMEL_HLCDC_PWMPS_MAX)
> >  		return -EINVAL;
> > @@ -204,6 +214,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (of_device_is_compatible(dev->parent->of_node,
> > +				    "atmel,sama5d3-hlcdc"))
> > +		chip->div1_clk_errata = true;
> > +
> > +	if (of_device_is_compatible(dev->parent->of_node,
> > +				    "atmel,at91sam9x5-hlcdc"))
> > +		chip->slow_clk_errata = true;
> 
> Generally I'd prefer this to be done as "SoC data", where the idea is to
> not rely on these checks at probe time (because they don't scale very
> well in the long term). Somewhat like the following:
> 
> 	struct atmel_hlcdc_soc {
> 		bool slow_clk_errata;
> 		bool div1_clk_errata;
> 	};
> 
> 	static const struct atmel_hlcdc_soc sama5d3_hlcdc = {
> 		.slow_clk_errata = false,
> 		.div1_clk_errata = true,
> 	};
> 
> 	static const struct atmel_hlcdc_soc at91sam9x5_hlcdc = {
> 		.slow_clk_errata = true,
> 		.div1_clk_errata = false,
> 	};
> 
> Then put those into a struct of_device_id table and do the matching
> using of_match_device(). Then you can simply do something like:
> 
> 	match = of_match_device(dev->parent, atmel_hlcdc_matches);
> 	if (match)
> 		chip->soc = match->data;

I'm perfectly with using device_id data field to achieve that.
I'll change that for my next version.

> 
> And then check on the fields set therein. This works optimally if the
> device isn't a subdevice because you have most of that code anyway. In
> this particular case the lookup needs to happen on the parent, which
> isn't so nice.
> 
> I'm willing to let this go for now, but if this list is going to grow
> I'll request that it be done differently so that .probe() doesn't need
> to be cluttered.
> 
> Also I wonder if it would be better to just add these new compatibles to
> the PWM block binding, too, since it's obviously the IP blocks that have
> these errata rather than the HLCDC block. So technically I think you'd
> have to make the driver support atmel,at91sam9x5-hlcdc-pwm and
> atmel,sama5d3-hlcdc-pwm anyway, and then you could just as well move to
> the above matching and SoC data.

Well, actually I did it because the datasheet describe the HLCDC IP
not the HLCDC-PWM and HLCDC-DC IPs (I mean, IP revision is attached to
the HLCDC block, not the HLCDC-PWM and HLCDC-DC sub devices).

Anyway, I'm okay to move MFD compatible string to the sub-device nodes,
but if I do so, I'm not sure it makes sense to have a specific
compatible string for the parent device ("atmel-hlcdc" would do the
job).

Another point in favor of the "one compatible string for all sub-device
revisions" is that it limits the number of mfd cells declared in the MFD
driver.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
