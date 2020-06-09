From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 9 Jun 2020 19:41:42 +0100
Message-ID: <20200609184142.GN4106@dell>
References: <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
 <a2bae71634fe288f067d5e92090b7561@walle.cc>
 <20200609171520.GC1019634@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200609171520.GC1019634@bogus>
Sender: linux-hwmon-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, david.m.ertman@intel.com, shiraz.saleem@intel.com, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u>
List-Id: linux-pwm@vger.kernel.org

On Tue, 09 Jun 2020, Rob Herring wrote:

> On Tue, Jun 09, 2020 at 05:01:17PM +0200, Michael Walle wrote:
> > Am 2020-06-09 16:42, schrieb Mark Brown:
> > > On Tue, Jun 09, 2020 at 04:38:31PM +0200, Michael Walle wrote:
> > > 
> > > >   mfd-device@10 {
> > > >     compatible = "simple-regmap", "simple-mfd";
> > > >     reg = <10>;
> > > >     regmap,reg-bits = <8>;
> > > >     regmap,val-bits = <8>;
> > > >     sub-device@0 {
> > > >       compatible = "vendor,sub-device0";
> > > >       reg = <0>;
> > > >     };
> > > 
> > > A DT binding like this is not a good idea, encoding the details of the
> > > register map into the DT binding makes it an ABI which is begging for
> > > trouble.  I'd also suggest that any device using a generic driver like
> > > this should have a specific compatible string for the device so we can
> > > go back and add quirks later if we need them.
> > 
> > Like in the spidev case, yes. But OTOH if I _just_ encode the parameters
> > for the regmap a MFD, Lee don't agree because its just a shim. So either
> > way I seem to be stuck here.
> > 
> > Where should I put the code to create an i2c driver, init a regmap and
> > populate its childen?
> 
> Find another driver doing this already and rename it 'simple-mfd' (no 
> relation to the DT binding) and add your compatible string to it. 
> 'Generic' or 'simple' drivers don't require generic/simple DT bindings.

Creating a generic driver is one of the options spinning around in my
head.  If nothing better comes of these discussions, I'll turn my hand
to it soon.

> Or extend the existing syscon driver to look up the bus_type and create 
> the regmap based on the bus type?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
