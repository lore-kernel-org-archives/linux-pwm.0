From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
Date: Mon, 08 Jun 2020 17:21:20 +0200
Message-ID: <7566ef30fea9740f427f392aabde0eac@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc> <20200515102848.GH271301@dell>
 <159e68b4ce53630ef906b2fcbca925bd@walle.cc> <20200608142413.GA4106@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200608142413.GA4106@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Am 2020-06-08 16:24, schrieb Lee Jones:
> On Mon, 25 May 2020, Michael Walle wrote:
>> Am 2020-05-15 12:28, schrieb Lee Jones:
>> > On Thu, 30 Apr 2020, Michael Walle wrote:
>> >
>> > > Hi Lee,
>> > >
>> > > Am 2020-04-23 19:45, schrieb Michael Walle:
>> > > > There might be multiple children with the device tree compatible, for
>> > > > example if a MFD has multiple instances of the same function. In this
>> > > > case only the first is matched and the other children get a wrong
>> > > > of_node reference.
>> > > > Add a new option to match also against the unit address of the child
>> > > > node. Additonally, a new helper OF_MFD_CELL_REG is added.
> 
> [...]
> 
>> > > > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
>> > > > index d01d1299e49d..c2c0ad6b14f3 100644
>> > > > --- a/include/linux/mfd/core.h
>> > > > +++ b/include/linux/mfd/core.h
>> > > > @@ -13,8 +13,11 @@
>> > > >  #include <linux/platform_device.h>
>> > > >
>> > > >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
>> > > > +#define MFD_OF_REG_VALID	BIT(31)
>> >
>> > What about 64bit platforms?
>> 
>> The idea was to have this as a logical number. I.e. for now you may 
>> only
>> have one subdevice per unique compatible string. In fact, if you have 
>> a
>> look at the ab8500.c, there are multiple "stericsson,ab8500-pwm"
>> subdevices. But there is only one DT node for all three of it. I guess
>> this works as long as you don't use phandles to reference the pwm node
>> in the device tree. Or you don't want to use device tree properties
>> per subdevice (for example the "timeout-sec" of a watchdog device).
> 
> This is not a good example, as the "stericsson,ab8500-pwm" is
> legitimate.  Here we are registering 3 potential devices, but only
> instantiating 1 of them.

Mh?

static const struct mfd_cell ab8500_devs[] = {
..
        OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
         OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
         OF_MFD_CELL("ab8500-pwm",
                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
..
}

And in pwm-ab8500.c there are three offsets based on the pdev->id.

Am I missing something here?

-- 
-michael
