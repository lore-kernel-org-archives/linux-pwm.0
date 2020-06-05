From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
Date: Fri, 5 Jun 2020 12:33:01 +0300
Message-ID: <CAHp75VfTAasC319uXz82dDufdnTGFhTnzJPXknk2+w-rnFfXTg@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-6-michael@walle.cc>
 <20200605084915.GE3714@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgFEJdO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 05:33:14 -0400
In-Reply-To: <20200605084915.GE3714@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Michael Walle <michael@walle.cc>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thom

On Fri, Jun 5, 2020 at 11:51 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 04 Jun 2020, Michael Walle wrote:

...

> > +     cycle = state->duty_cycle * config->max_duty_cycle;
> > +     do_div(cycle, state->period);
>
> Forgive my ignorance (I'm new here!), but what are these 2 lines
> doing?  Here we are multiplying the current duty_cycle with the
> maximum value, then dividing by the period.
>
> So in the case of PWM_MODE_1KHZ with a 50% duty cycle, you'd have:
>
>    (500000 * 0x20[16]) / 1000000 = [0x10]16
>
> Thus, the above gives as a proportional representation of the maximum
> valid value for placement into the cycle control register(s), right?
>
> Either way (whether I'm correct or not), I think it would be nice to
> mention this in a comment.  Maybe even clarify with a simple example.

IIRC PWM has a helper for that (to calc period based on PWM state and
new duty cycle %).

-- 
With Best Regards,
Andy Shevchenko
