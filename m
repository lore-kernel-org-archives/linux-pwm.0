From: Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Date: Fri, 22 May 2020 12:18:24 +0300
Message-ID: <20200522091824.GR1634618@smile.fi.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200522085613.ktb2ruw2virj337v-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, May 22, 2020 at 10:56:13AM +0200, Uwe Kleine-König wrote:
> On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:

> > +	io_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(io_base))
> 
> error message here?

platform core provides it. No need to duplicate (esp. taking into consideration
that it can issue IIRC three different error messages depending on actual error).

> 
> > +		return PTR_ERR(io_base);

-- 
With Best Regards,
Andy Shevchenko
