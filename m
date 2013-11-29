From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
Date: Fri, 29 Nov 2013 05:58:09 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828DD72F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131128212510.GC14689@mithrandir>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <Shawn.Guo@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, Jingchan
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

Thanks for your detail comments.

> > +	switch (fpc->counter_clk_select) {
> > +	case VF610_CLK_FTM0:
> > +		reg |= FTMSC_CLKSYS;
> > +		break;
> > +	case VF610_CLK_FTM0_FIX_SEL:
> > +		reg |= FTMSC_CLKFIX;
> > +		break;
> > +	case VF610_CLK_FTM0_EXT_SEL:
> > +		reg |= FTMSC_CLKEXT;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	reg |= fpc->clk_ps;
> 
> And another one above this line.
> 
> > +	writel(reg, fpc->base + FTM_SC);
> 
> I think with the proper locking in place what you should do is increment
> counter_clk_enable only here. That makes avoids having to decrement the
> count on error.
> 
> Similarly in fsl_counter_clock_disable() you can postpone decrementing
> the count until the very end.
> 

As the other mails we have talked about this that there are 8 channels
supported, but they share the same counter clock source. So we need to
make sure that when one channel is calling fsl_counter_clock_disable()
it shouldn't disable the counter clock if any other channel is still
enabled. Similary in fsl_counter clock_enable().

This is why I set counter_clk_enable property here.


--
Best Regards,


