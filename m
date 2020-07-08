From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v5 13/13] arm64: dts: freescale: sl28: enable fan support
Date: Wed, 08 Jul 2020 09:56:13 +0200
Message-ID: <d9a53ed9254a136a7bc161c2a93045b0@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-14-michael@walle.cc>
 <CACRpkdaPO7CGNrxmjL5QH1cxP5wqku1oMtQaQgJfeKiKqiGAOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdaPO7CGNrxmjL5QH1cxP5wqku1oMtQaQgJfeKiKqiGAOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

Am 2020-07-08 09:39, schrieb Linus Walleij:
> just a drive-by-comment:
> 
> On Mon, Jul 6, 2020 at 7:57 PM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
> 
>> Add a pwm-fan mapped to the PWM channel 0 which is connected to the
>> fan connector of the carrier.
>> 
>> Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
> 
> If you have a cooling device like this, do you also have a temperature
> sensor? In that case it makes sense to add a thermal zone and a
> policy, such as I did for a device in
> 6e97f0aaca4ca778905dd1dc667cbf379f4cae15

Yep, the CPU and DDR controller have temperatur sensors and there are
already thermal zones for them. We have the fan linked to the policies
in our vendor DTS overlay. For now I didn't want to include that here,
mainly because there are no labels in the fsl-ls1028a.dtsi for the
thermal zone/cooling maps/trips. But this is still on my TODO, when
this series finally make it into the kernel ;)

-michael
