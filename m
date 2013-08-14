Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E85CA9@DQHE06.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E849D8@DQHE06.ent.ti.com>
	<20130731115630.GH13298@lee--X1>
	<A874F61F95741C4A9BA573A70FE3998F82E850A9@DQHE06.ent.ti.com>
	<20130801080331.GK13298@lee--X1>
	<A874F61F95741C4A9BA573A70FE3998F82E85CA9@DQHE06.ent.ti.com>
Date: Wed, 14 Aug 2013 19:53:15 +0200
Message-ID: <CACRpkdY788S50pppULdkYDr4aVDR=uS-xh_GYyNDk-sv9+JEwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mfd: add LP3943 MFD driver
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, "Samuel Ortiz (sameo@linux.intel.com)" <sameo@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Mon, Aug 5, 2013 at 9:09 AM, Kim, Milo <Milo.Kim@ti.com> wrote:

> In the meantime, I've reviewed the pin control subsystem,
> I think it is not the best way to implement LP3943 driver.
> The GPIO controller is OK, but I can't make flexible pin assignment for the PWM
> operation.
> For example, multiple output pins can be controlled by one PWM generator.
> These pin assignment are configurable - not fixed type.

So it's more like a router than a PWM goes out on a certain pin,
you can route the same PWM output to e.g. all pins if you want
to, and each pin will have its own driver stage?

> And pinmux are only two cases - GPIO and PWM.
> I think current driver structure is better because LP3943 uses very limited
> pinctrl functionalities.
> Any suggestion for this?

Well if you'r going to do things like remuxing this dynamically
you'd use the pinctrl subsystem. But if you only want to pass
a certain static configuration from e.g. platform data or the device
tree, it can be done like this.

Yours,
Linus Walleij
