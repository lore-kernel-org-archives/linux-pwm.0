From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Date: Fri, 6 Mar 2020 08:51:29 +0100
Message-ID: <20200306075129.mzs22yjitkmgrthh@pengutronix.de>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
 <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
 <20200226163905.GH4136@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200226163905.GH4136-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 26, 2020 at 04:39:05PM +0000, Mark Brown wrote:
> On Wed, Feb 26, 2020 at 05:17:57PM +0100, Uwe Kleine-König wrote:
> > On Mon, Feb 24, 2020 at 04:58:59PM +0000, Mark Brown wrote:
> 
> > > This then means that there's no way for users to determine why the
> > > driver has failed to instantiate which can be frustrating.  It'd be
> > > better to at least have some dev_dbg() output when deferring so that
> > > there's something for people to go on without having to instrument the
> > > code.
> 
> > Not printing an error message is quite usual however. I think a generic
> 
> Usual yet also frustraing.
> 
> > approach that for example makes the list of devices that should be
> > retried to probe on the next opportunity inspectable would be nice.
> 
> That's not really the issue, the bigger issue is trying to figure out
> why things are stuck - what exactly caused things to fail to
> instantiate.

I wonder if we should do something like:

	ret = some_call(some, args);
	if (ret) {
		if (emit_errmsg_for_err(ret))
			dev_err(dev, "some_call failed: %pE\n", ERR_PTR(ret));
		return ret;
	}

and have emit_errmsg_for_err return true if ret != -EPROBE_DEFER or some
kernel parameter is given.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
