From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 9 Jun 2020 11:15:20 -0600
Message-ID: <20200609171520.GC1019634@bogus>
References: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
 <a2bae71634fe288f067d5e92090b7561@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a2bae71634fe288f067d5e92090b7561-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ranjani Sridharan <ranjani.sridharan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, david.m.ertman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shiraz.saleem-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 09, 2020 at 05:01:17PM +0200, Michael Walle wrote:
> Am 2020-06-09 16:42, schrieb Mark Brown:
> > On Tue, Jun 09, 2020 at 04:38:31PM +0200, Michael Walle wrote:
> > 
> > >   mfd-device@10 {
> > >     compatible = "simple-regmap", "simple-mfd";
> > >     reg = <10>;
> > >     regmap,reg-bits = <8>;
> > >     regmap,val-bits = <8>;
> > >     sub-device@0 {
> > >       compatible = "vendor,sub-device0";
> > >       reg = <0>;
> > >     };
> > 
> > A DT binding like this is not a good idea, encoding the details of the
> > register map into the DT binding makes it an ABI which is begging for
> > trouble.  I'd also suggest that any device using a generic driver like
> > this should have a specific compatible string for the device so we can
> > go back and add quirks later if we need them.
> 
> Like in the spidev case, yes. But OTOH if I _just_ encode the parameters
> for the regmap a MFD, Lee don't agree because its just a shim. So either
> way I seem to be stuck here.
> 
> Where should I put the code to create an i2c driver, init a regmap and
> populate its childen?

Find another driver doing this already and rename it 'simple-mfd' (no 
relation to the DT binding) and add your compatible string to it. 
'Generic' or 'simple' drivers don't require generic/simple DT bindings.

Or extend the existing syscon driver to look up the bus_type and create 
the regmap based on the bus type?

Rob
