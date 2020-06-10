From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
Date: Wed, 10 Jun 2020 11:16:10 -0600
Message-ID: <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
References: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc> <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc> <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc> <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc> <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc> <20200610071940.GS4106@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200610071940.GS4106@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, david.m.ertman@intel.com, shiraz.saleem@intel.com, Mark Brown <broonie@kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux HWMON List <linux-hwmon@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.redin>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jun 10, 2020 at 1:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 10 Jun 2020, Michael Walle wrote:
> > Am 2020-06-09 21:45, schrieb Lee Jones:
> > > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > > We do not need a 'simple-regmap' solution for your use-case.
> > > > >
> > > > > Since your device's registers are segregated, just split up the
> > > > > register map and allocate each sub-device with it's own slice.
> > > >
> > > > I don't get it, could you make a device tree example for my
> > > > use-case? (see also above)
> > >
> > >     &i2cbus {
> > >         mfd-device@10 {
> > >             compatible =3D "simple-mfd";
> > >             reg =3D <10>;
> > >
> > >             sub-device@10 {
> > >                 compatible =3D "vendor,sub-device";
> > >                 reg =3D <10>;
> > >             };
> > >    };
> > >
> > > The Regmap config would be present in each of the child devices.
> > >
> > > Each child device would call devm_regmap_init_i2c() in .probe().
> >
> > Ah, I see. If I'm not wrong, this still means to create an i2c
> > device driver with the name "simple-mfd".
>
> Yes, it does.

TBC, while fine for a driver to bind on 'simple-mfd', a DT compatible
with that alone is not fine.

> > Besides that, I don't like this, because:
> >  - Rob already expressed its concerns with "simple-mfd" and so on.
>
> Where did this take place?  I'd like to read up on this.
>
> >  - you need to duplicate the config in each sub device
>
> You can have a share a single config.
>
> >  - which also means you are restricting the sub devices to be
> >    i2c only (unless you implement and duplicate other regmap configs,
> >    too). For this driver, SPI and MMIO may be viable options.
>
> You could also have a shared implementation to choose between different
> busses.

I think it is really the syscon mfd driver you want to generalize to
other buses. Though with a quick look at it, there's not really a
whole lot to share. The regmap lookup would be the main thing. You are
going to need a driver instance for each bus type.

> > Thus, I'd rather implement a simple-mfd.c which implement a common
> > I2C driver for now and populate its children using
> > devm_of_platform_populate(). This could be extended to support other
> > type of regmaps like SPI in the future.
> >
> > Also some MFD drivers could be moved to this, a likely candidate is
> > the smsc-ece1099.c. Although I don't really understand its purpose,
> > if don't have CONFIG_OF.
> >
> > Judging from the existing code, this simple-mfd.c wouldn't just be
> > "a list of compatible" strings but also additional quirks and tweaks
> > for particular devices in this list.

Yes, this is why specific compatible strings are required.

> Hold off on the simple-mfd.c idea, as I'm not taken by it yet and
> wouldn't want you to waste your time.  I have another idea which would
> help.  Give me a few days to put something together.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
