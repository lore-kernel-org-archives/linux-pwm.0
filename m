From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Date: Tue, 26 May 2020 06:42:03 -0700
Message-ID: <20200526134203.GA51584@roeck-us.net>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
 <53619c02-8c0f-3eec-cccc-16e779b8c425@roeck-us.net>
 <BYAPR12MB30145EC4578F64EAD1233357ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB30145EC4578F64EAD1233357ADB00-ZGDeBxoHBPnJoSvCh4fbtgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org" <kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org>, "jdelvare-IBi9RG/b67k@public.gmane.org" <jdelvare-IBi9RG/b67k@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Bitan Biswas <bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, May 26, 2020 at 12:08:14PM +0000, Sandipan Patra wrote:
> Hi,
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> On Behalf Of Guenter Roeck
> > Sent: Tuesday, May 26, 2020 5:12 PM
> > To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Thierry Reding
> > <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; u.kleine-
> > koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org; jdelvare-IBi9RG/b67k@public.gmane.org;
> > robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> > Cc: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Bitan Biswas <bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>;
> > linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
> > module support
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 5/25/20 10:06 PM, Sandipan Patra wrote:
> > > This change has 2 parts:
> > > 1. Add support for profiles mode settings.
> > >     This allows different fan settings for trip point temp/hyst/pwm.
> > >     T194 has multiple fan-profiles support.
> > >
> > > 2. Add pwm-fan remove support. This is essential since the config is
> > >     tristate capable.
> > >
> > > Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/hwmon/pwm-fan.c | 112
> > > ++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 100 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> > > 30b7b3e..26db589 100644
> > > --- a/drivers/hwmon/pwm-fan.c
> > > +++ b/drivers/hwmon/pwm-fan.c
> > 
> > [ ... ]
> > 
> > >
> > > +static int pwm_fan_remove(struct platform_device *pdev) {
> > > +     struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> > > +     struct pwm_args args;
> > > +
> > > +     if (!ctx)
> > > +             return -EINVAL;
> > > +
> > > +     if (IS_ENABLED(CONFIG_THERMAL))
> > > +             thermal_cooling_device_unregister(ctx->cdev);
> > > +
> > > +     pwm_get_args(ctx->pwm, &args);
> > > +     pwm_config(ctx->pwm, 0, args.period);
> > > +     pwm_disable(ctx->pwm);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > 
> > I don't think you actually tested this. I would suggest to make yourself familiar
> > with 'devm' functions and their use, and then resubmit.
> > 
> 
> Thanks Guenter.
> I missed to mention about devm while unregistering the cooling device.
> That would definitely cause a mistake in code. I am noting it for further patch.
> 
For that part, I am extremely surprised that it is not handled by the
thermal subsystem. Does each thermal driver need this kind of code ?

> For a better clarity, I will push next version of this patch to handle only multiple profiles support.
> "remove fan module" will be supported by a separate patch altogether.
> 

I asked you to look into "devm" functionality. I ask you again.
If you still think that a remove function is needed, I will require
detailed reasoning. Please be prepared to explain why devm functions
do not work for this driver.

Guenter
