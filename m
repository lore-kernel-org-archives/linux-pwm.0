From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
Date: Wed, 10 Jun 2020 11:27:19 +0200
Message-ID: <b06a79c845e0ab251235d30f7dc94dd5@walle.cc>
References: <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc> <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc> <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc> <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc> <20200610071940.GS4106@dell>
 <f7b2b690750edd022000ab56d2f58154@walle.cc> <20200610075615.GT4106@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200610075615.GT4106@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ranjani Sridharan <ranjani.sridharan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, david.m.ertman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shiraz.saleem-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K?=
List-Id: linux-pwm@vger.kernel.org

Am 2020-06-10 09:56, schrieb Lee Jones:
> On Wed, 10 Jun 2020, Michael Walle wrote:
> 
>> Am 2020-06-10 09:19, schrieb Lee Jones:
>> > On Wed, 10 Jun 2020, Michael Walle wrote:
>> > > Am 2020-06-09 21:45, schrieb Lee Jones:
>> > > > On Tue, 09 Jun 2020, Michael Walle wrote:
>> > > > > > We do not need a 'simple-regmap' solution for your use-case.
>> > > > > >
>> > > > > > Since your device's registers are segregated, just split up the
>> > > > > > register map and allocate each sub-device with it's own slice.
>> > > > >
>> > > > > I don't get it, could you make a device tree example for my
>> > > > > use-case? (see also above)
>> > > >
>> > > >     &i2cbus {
>> > > >         mfd-device@10 {
>> > > >             compatible = "simple-mfd";
>> > > >             reg = <10>;
>> > > >
>> > > >             sub-device@10 {
>> > > >                 compatible = "vendor,sub-device";
>> > > >                 reg = <10>;
>> > > >             };
>> > > >    };
>> > > >
>> > > > The Regmap config would be present in each of the child devices.
>> > > >
>> > > > Each child device would call devm_regmap_init_i2c() in .probe().
>> > >
>> > > Ah, I see. If I'm not wrong, this still means to create an i2c
>> > > device driver with the name "simple-mfd".
>> >
>> > Yes, it does.
>> >
>> > > Besides that, I don't like this, because:
>> > >  - Rob already expressed its concerns with "simple-mfd" and so on.
>> >
>> > Where did this take place?  I'd like to read up on this.
>> 
>> In this thread:
>> https://lore.kernel.org/linux-devicetree/20200604211039.12689-1-michael-QKn5cuLxLXY@public.gmane.org/T/#m16fdba5962069e7cd4aa817582ee358c9fe2ecbf
>> 
>> >
>> > >  - you need to duplicate the config in each sub device
>> >
>> > You can have a share a single config.
>> >
>> > >  - which also means you are restricting the sub devices to be
>> > >    i2c only (unless you implement and duplicate other regmap configs,
>> > >    too). For this driver, SPI and MMIO may be viable options.
>> >
>> > You could also have a shared implementation to choose between different
>> > busses.
>> 
>> Then what is the difference between to have this shared config in the
>> parent driver only and use the functions which are already there, i.e.
>> dev_get_regmap(parent). But see, below, I'll wait with what you're
>> coming up.
> 
> The difference is the omission of an otherwise pointless/superfluous
> driver.  Actually, it's the difference between the omission of 10
> pointless drivers!

If you want to omit anything generic in the device tree - and as far as
I understand it - that should be the way to go, the specific compatible
string of the parent device has to go somewhere. Thus I'd appreciate
a consolidated (MFD) driver which holds all these, as you say it
pointless drivers. Because IMHO they are not pointless, rather they are
the actual drivers for the MFD. Its sub nodes are just an implementation
detail to be able to use the OF bindings (like your clock example or
a phandle to a PWM controller). Just because it is almost nothing there
except the regmap instantiation doesn't mean it is not a valid MFD 
driver.
And there is also additional stuff, like clock enable, version checks, 
etc.

-michael

>> > > Thus, I'd rather implement a simple-mfd.c which implement a common
>> > > I2C driver for now and populate its children using
>> > > devm_of_platform_populate(). This could be extended to support other
>> > > type of regmaps like SPI in the future.
>> > >
>> > > Also some MFD drivers could be moved to this, a likely candidate is
>> > > the smsc-ece1099.c. Although I don't really understand its purpose,
>> > > if don't have CONFIG_OF.
>> > >
>> > > Judging from the existing code, this simple-mfd.c wouldn't just be
>> > > "a list of compatible" strings but also additional quirks and tweaks
>> > > for particular devices in this list.
>> >
>> > Hold off on the simple-mfd.c idea, as I'm not taken by it yet and
>> > wouldn't want you to waste your time.  I have another idea which would
>> > help.  Give me a few days to put something together.
>> 
>> Sure. I'm just glad there is now a discussion about this issue.
> 
> It's very much in my mind.
> 
> I've been meaning to do something about it for quite some time.
