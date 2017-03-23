From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Thu, 23 Mar 2017 11:11:09 +0100
Message-ID: <CACRpkdaqoJ6J+qoxOyGsT4X=-e1PH71_2oi0hQeQh72T0OnBfw@mail.gmail.com>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com> <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
 <20170317101747.67a09ccd@gmail.com> <20170320135131.GP22463@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170320135131.GP22463@ulmo.ba.sec>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ralph Sennhauser <ralph.sennhauser@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 20, 2017 at 2:51 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Fri, Mar 17, 2017 at 10:17:47AM +0100, Ralph Sennhauser wrote:
>> On Thu, 16 Mar 2017 17:03:05 +0100
>> Linus Walleij <linus.walleij@linaro.org> wrote:
> [...]
>> > > +static void mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
>> > > +static void mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
>> >
>> > I think both of these need to be tagged __maybe_unused to not give
>> > noise in randconfig builds.
>>
>> I haven't seen any warnings with CONFIG_PWM disabled. Which
>> configuration you expect to trigger a warning? mvebu_pwm_probe should
>> be the same, right?
>
> It's got nothing to do with CONFIG_PWM and as far as I can tell your
> usage of IS_ENABLED() is fine here. However, if you try building the
> driver with a !PM configuration, both *_suspend() and *_resume() end
> up being unused and giving you a warning.

Yes I was referring to the !PM case.

Those are not found by zeroday builds.

But they are found a couple of days later by Arnd Bergmann running
randconfig builds.

Yours,
Linus Walleij
