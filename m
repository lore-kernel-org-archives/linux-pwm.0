From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 02/16] mfd: mfd-core: Don't overwrite the dma_mask of
 the child device
Date: Tue, 28 Apr 2020 17:29:38 +0300
Message-ID: <20200428142938.GX185537@smile.fi.intel.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-3-michael@walle.cc>
 <20200428124548.GS185537@smile.fi.intel.com>
 <3cd3705a-4f48-6a46-e869-3ee11dc17323@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3cd3705a-4f48-6a46-e869-3ee11dc17323@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedae>
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 28, 2020 at 02:06:20PM +0100, Robin Murphy wrote:
> On 2020-04-28 1:45 pm, Andy Shevchenko wrote:
> > On Thu, Apr 23, 2020 at 07:45:29PM +0200, Michael Walle wrote:
> > > Commit cdfee5623290 ("driver core: initialize a default DMA mask for
> > > platform device") initialize the DMA of a platform device. But if the
> > > parent doesn't have a dma_mask set, for example if it's an I2C device,
> > > the dma_mask of the child platform device will be set to zero again.
> > > Which leads to many "DMA mask not set" warnings, if the MFD cell has the
> > > of_compatible property set.
> > 
> > I'm wondering why parent doesn't have it.
> 
> Because the parent isn't on a DMA-capable bus, and thus really shouldn't
> have a valid DMA configuration ever.

Then how come a child is DMA capable? MFD takes a physical device node as a
parent and creates one of several children with that device as a parent. DMA
mask is a property of the device which *does DMA*. Obviously a child is not
correct device for that.

Where am I mistaken?

> > I remember we have explicit patches in the past for buses such as PCI and AMBA
> > to set default DMA mask for all physical devices on the respective bus, of
> > course they can individually override it later.
> > 
> > So, this seems to me a paper over the real issue (absence of default DMA mask
> > where it's needed) and devices should explicitly define it if they disagree
> > with default.
> > 
> > If I'm wrong, you really need elaborate commit message much better.
> 
> The problem here is that MFD children are created as platform devices
> (regardless of what their parent is) and assigned an of_node, at which point
> they look pretty much indistinguishable from SoC devices created by the
> of_platform code, that *do* have to be assumed to be DMA-capable to prevent
> ~90% of existing devicetrees from breaking.
> 
> Of course the real fundamental issue is the platform bus itself, but it's
> way too late to fix that :(

I don't think it's an issue, rather in model you are describing. Or I miss
something not so obvious.

-- 
With Best Regards,
Andy Shevchenko
