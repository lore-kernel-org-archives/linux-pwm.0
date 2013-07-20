Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E815C3@DQHE06.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E815C3@DQHE06.ent.ti.com>
Date: Sat, 20 Jul 2013 22:14:39 +0200
Message-ID: <CACRpkdYF=ZDqqoU6Kq4cwgaufUjpQmX+dxUexqcvb=KiqDdBoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: add LP3943 MFD driver
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, devicetree@vger.kernel.org

On Tue, Jul 16, 2013 at 4:38 AM, Kim, Milo <Milo.Kim@ti.com> wrote:

This needs to be reviewed by the devicetree people.
Please break out the bindings separately and include
devicetree@vger.kernel.org on that review.

> +++ b/Documentation/devicetree/bindings/mfd/lp3943.txt
> @@ -0,0 +1,23 @@
> +Bindings for TI/National Semiconductor LP3943 Driver
> +
> +Required properties:
> +  - compatible: "ti,lp3943"
> +  - reg: 7bit I2C slave address. 0x60 ~ 0x67
> +
> +Optional properties:
> +  - ti,pwm0, ti,pwm1: Output channel definition for PWM port 0 and 1
> +                      0 = invalid, 1 = LED0, 2 = LED 1, ... 16 = LED15
> +
> +Datasheet
> +  http://www.ti.com/lit/ds/snvs256b/snvs256b.pdf
> +
> +Application note: How to use LP3943 as a GPIO expander and PWM generator
> +  http://www.ti.com/lit/an/snva287a/snva287a.pdf

Do we usually put these things into bindings?

> +Example:
> +
> +       lp3943@60 {
> +               compatible = "ti,lp3943";
> +               reg = <0x60>;
> +               pwm1 = /bits/ 8 <2>;    /* use LED1 output as PWM #1 */
> +       };

OK so there is a way to state which lines are used for PWM.

I think you should also specify which lines are used for GPIO,
and which lines are used for LEDs.

And I'd like the masks to be passed to each subdriver, so we
can avoid the scenario where one and the same line gets
used for GPIO, LED and PWM at the same time.

Yours,
Linus Walleij
