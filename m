From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
Date: Mon, 2 Dec 2013 02:45:07 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828E17D3@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
 <1DD289F6464F0949A2FCA5AA6DC23F828DD76C@039-SN2MPN1-011.039d.mgd.msft.net>
 <20131129092224.GB22771@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:7031
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752584Ab3LBCpP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 1 Dec 2013 21:45:15 -0500
In-Reply-To: <20131129092224.GB22771@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <Shawn.Guo@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, Jingchan

> > > > +#define FTM_CNTIN_VAL       0x00
> > >
> > > Do we really need this?
> > >
> >
> > Maybe not, I think that the initial value maybe modified in the future.
> > And this can be more easy to ajust it.
> 
> Why would it need to be modified?
> 

Well, for the PWM function modifying it make no sense, so I'll remove this. 


> > > > +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> > > > +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> > >
> > > And these:
> > >
> > > 	writel(period - 1, fpc->base + FTM_MOD);
> > > 	writel(duty, fpc->base + FTM_CV(pwm->hwpwm));
> > >
> > > Although now that I think about it, this seems broken. The period is
> > > set in a global register, so I assume it is valid for all channels.
> > > What if you want to use different periods for individual channels?
> > > The way I read this the last one to be configured will win and
> > > change the period to whatever it wants. Other channels won't even
> notice.
> > >
> >
> > That's right. And all the 8 channels share the same period settings.
> >
> > > Is there a way to set the period per channel?
> > >
> >
> > Not yet. Only could we do is to set the duty value individually for
> > each channel. So here is a limitation for the cusumers that all the 8
> channels'
> > period values should be the same.
> 
> That will need to be handled some way. Perhaps the easiest would be to
> check whether or not another channel is already running and check that
> indeed the period as requested by the new channel matches that of any
> running channels. If it doesn't match, then pwm_config() should fail.
> 
> When you do that you can also optimize this a bit by only setting the
> frequency once. Whenever a new channel is configured it will have the same
> period and therefore the register doesn't need to be reprogrammed.
> 

Yes, if it dosen't match it should fail, or nothing to do with the period
register if it's not the first channel to be configured.


> > > > +static void fsl_pwm_disable(struct pwm_chip *chip, struct
> > > > +pwm_device
> > > *pwm)
> > > > +{
> > > > +	struct fsl_pwm_chip *fpc;
> > > > +
> > > > +	fpc = to_fsl_chip(chip);
> > > > +
> > > > +	fsl_counter_clock_disable(fpc);
> > > > +}
> > >
> > > Same here. Since you can't propagate the error, perhaps an error
> > > message would be appropriate here?
> > >
> >
> > Well, in fsl_counter_clock_disable(fpc); only '0' could be returned,
> > maybe let it a void type value to return is better.
> > Just like:
> > static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc) 

