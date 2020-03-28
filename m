From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
Date: Sat, 28 Mar 2020 13:04:50 +0100
Message-ID: <ef10a6f07f093c282df7fe94057cc7c7@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-gpio <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc
List-Id: linux-pwm@vger.kernel.org

Hi Bartosz,

Am 2020-03-18 10:14, schrieb Bartosz Golaszewski:
> wt., 17 mar 2020 o 21:50 Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> napisał(a):
>> 
>> This adds support for the GPIO controller of the sl28 board management
>> controller. This driver is part of a multi-function device.
>> 
>> Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
> 
> Hi Michael,
> 
> thanks for the driver. Please take a look at some comments below.
> 
>> ---

[..]

>> +#define GPIO_REG_DIR   0
>> +#define GPIO_REG_OUT   1
>> +#define GPIO_REG_IN    2
>> +#define GPIO_REG_IE    3
>> +#define GPIO_REG_IP    4
> 
> These values would be more clear if they were defined as hex.
> 
>> +
>> +#define GPI_REG_IN     0
>> +
>> +#define GPO_REG_OUT    0
> 
> Please also use a common prefix even for defines.

The GPIO_, GPI_ and GPO_ prefixes corresponds to the different
flavours. Do they still need a common prefix? Ie. the GPI_REG_IN
has nothing to do with GPO_REG_OUT, nor has both something
to do with the GPIO_REG_IN and GPIO_REG_OUT. I could prefix them
with SL28CPLD_ though. But I don't know if that is what you had
in mind because then they would be SL28CPLD_GPIO_REG_IN and
SL28CPLD_GPI_REG_IN for example.

-michael
