From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Date: Sat, 18 Apr 2020 10:23:00 +0200
Message-ID: <20200418082300.mucrg2srysvvjbfn@pengutronix.de>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
 <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
 <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200415141856.ck3w3gtae4bsxyfl@pengutronix.de>
 <BYAPR12MB30149D2715DC575A030A7F59ADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200417135027.wkj6bxiplnehsa5s@pengutronix.de>
 <BYAPR12MB3014041BFFC43AF5EB3BC27CADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3014041BFFC43AF5EB3BC27CADD90-ZGDeBxoHBPnJoSvCh4fbtgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Fri, Apr 17, 2020 at 02:53:22PM +0000, Sandipan Patra wrote:
> > To put my expression in words: pick the maximum of the possible periods that
> > are less or equal to the requested value.  Maybe this is better
> > understandable:
> > 
> >         max { x ∊ implementablePeriods | x <= requestedPeriod }
> > 
> > ?
> 
> I think I got your question.
> Should tegra_pwm_config() not return error (EINVAL) when the requested period is
> invalid but it should configure to a nearest possible value?

If you cannot configure according to the above rule, yes, return an
error code. EINVAL is the usual one I think (some also return ERANGE).

> > > Yes, the output stops as soon as the PWM_ENABLE bit is cleared in
> > > hardware. Then The output is set to 0 (which is inactive).
> > > Once .disable() => tegra_pwm_disable() gets invoked, enable bit is
> > > cleared and hence PWM will possess no output signal.
> > > tegra_pwm_config() will be invoked for any new configuration request.
> > 
> > Some drivers already have a "Limitations" section in their header.
> > Please take a look at the existing examples and provide something similar. (Note
> > you still didn't answer "How does a running PWM behave when the register is
> > updated? Does it complete the currently running period?". I assume the answer
> > to the second question is "No" (and the first is only there for rhetoric reasons).)
> >
>  
> 1. I will add the below comments as Limitations:
> -	When PWM is disabled, the output is driven to 0 and

In fact, this is a good property. So the only problem is, that for both
stop and reconfiguration the currently running period isn't completed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
