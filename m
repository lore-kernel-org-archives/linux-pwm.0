From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 02/16] mfd: mfd-core: Don't overwrite the dma_mask of
 the child device
Date: Tue, 28 Apr 2020 15:45:48 +0300
Message-ID: <20200428124548.GS185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-3-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200423174543.17161-3-michael-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz@kernel>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 07:45:29PM +0200, Michael Walle wrote:
> Commit cdfee5623290 ("driver core: initialize a default DMA mask for
> platform device") initialize the DMA of a platform device. But if the
> parent doesn't have a dma_mask set, for example if it's an I2C device,
> the dma_mask of the child platform device will be set to zero again.
> Which leads to many "DMA mask not set" warnings, if the MFD cell has the
> of_compatible property set.

I'm wondering why parent doesn't have it.
I remember we have explicit patches in the past for buses such as PCI and AMBA
to set default DMA mask for all physical devices on the respective bus, of
course they can individually override it later.

So, this seems to me a paper over the real issue (absence of default DMA mask
where it's needed) and devices should explicitly define it if they disagree
with default.

If I'm wrong, you really need elaborate commit message much better.

-- 
With Best Regards,
Andy Shevchenko
