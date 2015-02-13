From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] clk: Add PWM clock driver
Date: Fri, 13 Feb 2015 19:03:34 +0100
Message-ID: <1423850614.4182.53.camel@pengutronix.de>
References: <1418381269-26399-1-git-send-email-p.zabel@pengutronix.de>
	 <54DE3152.6050204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54DE3152.6050204-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Janusz =?UTF-8?Q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Stephen,

Am Freitag, den 13.02.2015, 09:16 -0800 schrieb Stephen Boyd:
> On 12/12/14 02:47, Philipp Zabel wrote:
> > +
> > +const struct clk_ops clk_pwm_ops = {
> 
> static?
[...]
> > +int clk_pwm_probe(struct platform_device *pdev)
> 
> static?
[...]
> > +int clk_pwm_remove(struct platform_device *pdev)
> 
> static?

Yes indeed. Next round will have this fixed, thank you.

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
