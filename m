From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Date: Wed, 26 Feb 2020 17:17:57 +0100
Message-ID: <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200224165859.GJ6215-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Feb 24, 2020 at 04:58:59PM +0000, Mark Brown wrote:
> On Mon, Feb 24, 2020 at 02:40:48PM +0000, Jon Hunter wrote:
> > Deferred probe is an expected return value for devm_pwm_get(). Given
> > that the driver deals with it properly, there's no need to output a
> > warning that may potentially confuse users.
> 
> >  		ret = PTR_ERR(drvdata->pwm);
> > -		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> 
> This then means that there's no way for users to determine why the
> driver has failed to instantiate which can be frustrating.  It'd be
> better to at least have some dev_dbg() output when deferring so that
> there's something for people to go on without having to instrument the
> code.

Not printing an error message is quite usual however. I think a generic
approach that for example makes the list of devices that should be
retried to probe on the next opportunity inspectable would be nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
