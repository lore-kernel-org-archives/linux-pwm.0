Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: RE: [PATCH 0/3] LP3943 MFD driver for a GPIO expander and a PWM
 generator
Date: Mon, 22 Jul 2013 01:19:10 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E83168@DQHE06.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E815BC@DQHE06.ent.ti.com>
 <CACRpkdaJGwPLzzUuHFZye0N5iAwH2Vn8vbdwz6qv9v4F9bmGbg@mail.gmail.com>
In-Reply-To: <CACRpkdaJGwPLzzUuHFZye0N5iAwH2Vn8vbdwz6qv9v4F9bmGbg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi Linus,
Thanks for your review.

> On Tue, Jul 16, 2013 at 4:38 AM, Kim, Milo <Milo.Kim@ti.com> wrote:
>=20
> > LP3943 is an integrated device capable of driving 16 output channels.
> > It supports a GPIO expander and a PWM generator.
>=20
> But actually the data sheet describes it as a LED driver with PWM
> chip.
>=20
> Do you have use cases not using it for LEDs but other thing or why
> do you want to model the 16 LED lines as GPIO lines?
> Why can't you just have a drivers/leds/* as for any other LED
> chip?

We have two ways to provide LED functions.

(a) Creating LP3943 LED driver.
This is what you mentioned.
LP3943 MFD will consist of GPIO, LED and PWM drivers

(b) Using a LED PWM driver with the PWM generator
With LP3943 PWM driver, we can control LEDs by using LED PWM driver
under drivers/leds/leds-pwm.c
Then, the MFD consists of just two drivers - GPIO and PWM.
LP3943 PWM driver can be used as general usages -
Not only simple LED drivers but also the PWM signal input for a backlight d=
evice.
That's why I prefer to the second way.

> Atleast some good explanation of this needs to be found in the
> patch text and also as comments in Kconfig and the code I think.

I should describe the usage of the 'leds-pwm' driver for LED lighting.
Thanks for this guideline.

Regards,
Milo
