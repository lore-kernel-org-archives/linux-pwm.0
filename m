From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
Date: Fri, 05 Jun 2020 22:07:36 +0200
Message-ID: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc> <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200605105026.GC5413-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

Am 2020-06-05 12:50, schrieb Mark Brown:
> On Fri, Jun 05, 2020 at 07:57:09AM +0100, Lee Jones wrote:
>> On Thu, 04 Jun 2020, Michael Walle wrote:
> 
>> > +	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
>> > +	if (IS_ERR(sl28cpld->regmap))
>> > +		return PTR_ERR(sl28cpld->regmap);
> 
>> This is now a shared memory allocator and not an MFD at all.
> 
>> I'm clamping down on these type of drivers!
> 
>> Please find a better way to accomplish this.
> 
> What is the concern with this?  Looking at the patch I'm guessing the
> concern would be that the driver isn't instantiating any MFD children
> and instead requiring them to be put in the DT?
> 
>> Potentially using "simple-mfd" and "simple-regmap".
> 
>> The former already exists and does what you want.  The latter doesn't
>> yet exist, but could solve your and lots of other contributor's
>> issues.
> 
> I have no idea what you are thinking of when you say "simple-regmap" so
> it is difficult to comment.

I guess, Lee is suggesting to be able to create a regmap instance via
device tree (and populate its child nodes?). Like
   compatible = "syscon", "simple-mfd";
but for any regmap, not just MMIO.

But, there is more in my driver:
  (1) there is a version check
  (2) there is another function for which there is no suitable linux
      subsystem I'm aware of and thus which I'd like to us sysfs
      attributes for: This controller supports 16 non-volatile
      configuration bits. (this is still TBD)

I don't see what is different between this driver and for example the
gateworks-gsc.c. Just that mine doesn't use a global register set, but
local offsets and a base for each component. From a hardware
perspective its one device behind an I2C address providing different
functions across multiple driver subsystems.

Actually, I've tried to remove the devm_of_platform_populate() and
instead added the "simple-mfd" to my mfd node:
  compatible = "kontron,sl28cpld-r1", "simple-mfd";

I guess that doesn't work because the device is below the i2c bus?

-- 
-michael
