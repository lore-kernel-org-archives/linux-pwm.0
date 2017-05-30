From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 2/2] gpio: mvebu: fix gpio bank registration when pwm is used
Date: Tue, 30 May 2017 18:35:22 +0200
Message-ID: <CACQ1gAj3q8cqqSOj732vf7uw10yYis46jExM+zzq6gtELhwjsQ@mail.gmail.com>
References: <20170530122848.2803-1-richard.genoud@gmail.com>
 <20170530122848.2803-2-richard.genoud@gmail.com> <87y3tetrg4.fsf@free-electrons.com>
 <CACQ1gAhy_S16YfxQ1eOJUX45rdnjrsPFckYJm_1OHGW0CThg0g@mail.gmail.com> <20170530171418.42713515@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170530171418.42713515@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

2017-05-30 17:14 GMT+02:00 Ralph Sennhauser <ralph.sennhauser@gmail.com>:
> Hi Richard
>
> On Tue, 30 May 2017 16:45:24 +0200
> Richard Genoud <richard.genoud@gmail.com> wrote:
>
>> 2017-05-30 15:16 GMT+02:00 Gregory CLEMENT
>> <gregory.clement@free-electrons.com>:
>> > Hi Richard,
>> Hi Greg !
>>
>> >
>> >  On mar., mai 30 2017, Richard Genoud <richard.genoud@gmail.com>
>> > wrote:
>> >> If more than one gpio bank has the "pwm" property, only one will be
>> >> registered successfully, all the others will fail with:
>> >> mvebu-gpio: probe of f1018140.gpio failed with error -17
>> >>
>> >> That's because in alloc_pwms(), the chip->base (aka "int pwm"),
>> >> was not set (thus, ==0) ; and 0 is a meaningful start value in
>> >> alloc_pwm(). What was intended is chip->base = -1.
>> >> Like that, the numbering will be done auto-magically
>> >>
>> >> Tested on clearfog-pro (Marvell 88F6828)
>> >>
>> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> >> ---
>> >>  drivers/gpio/gpio-mvebu.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
>> >> index cdef2c78cb3b..4734923e11fd 100644
>> >> --- a/drivers/gpio/gpio-mvebu.c
>> >> +++ b/drivers/gpio/gpio-mvebu.c
>> >> @@ -768,6 +768,7 @@ static int mvebu_pwm_probe(struct
>> >> platform_device *pdev, mvpwm->chip.dev = dev;
>> >>       mvpwm->chip.ops = &mvebu_pwm_ops;
>> >>       mvpwm->chip.npwm = mvchip->chip.ngpio;
>> >> +     mvpwm->chip.base = -1;
>> >
>> > Why not using
>> > mvpwm->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;
>> > as it is done in the mvebu_gpio_probe() function?
>> Yes, that was my first move:
>> mvpwm->chip.base = mvchip->chip.base;
>>
>> But after some reflexion, mvpwm->chip.base is not the GPIO base, it's
>> the PWM base,
>> (mvpwm->chip is a struct pwm_chip), so it would we weird to have
>> "holes" in the declared PWMs.
>> I'm not clear, so here's an example:
>> If, in the DTS, we have:
>>             gpio0: gpio@18100 {
>>                 compatible = "marvell,armada-370-xp-gpio",
>>                          "marvell,orion-gpio";
>>                 reg = <0x18100 0x40>, <0x181c0 0x08>;
>>                 reg-names = "gpio";  /* "pwm" missing */
>> [...]
>>             gpio1: gpio@18140 {
>>                 compatible = "marvell,armada-370-xp-gpio",
>>                          "marvell,orion-gpio";
>>                 reg = <0x18140 0x40>, <0x181c8 0x08>;
>>                 reg-names = "gpio", "pwm";
>> In this case, if gpio0 is not declared as PWM capable, the PWM
>> numbering will start at 32 if we have
>> mvpwm->chip.base = mvchip->chip.base;
>> but it will start at 0 if we have mvpwm->chip.base = -1;
>>
>> The pros for having mvpwm->chip.base = mvchip->chip.base; is mainly
>> the stable numbering:
>> if we add the "pwm" feature to gpio0 afterwards, the pwm numbering in
>> sysfs will stay the same.
>> And if we have mvpwm->chip.base = -1; the pwm numbering will be
>> shifted.
>>
>> Looking back at the V5 of this patch
>> https://www.spinics.net/lists/kernel/msg2484889.html
>> There was the line:
>> mvpwm->chip.base = mvchip->chip.base;
>> I guess it got lost in the v6 rebase.
>>
>> So I could change it back, but I'm not sure which one is better.
>
> Thierry Redding pointed out that the region might already be occupied
> by another PWM chip, unlikely but not impossible. That's why it got
> changed for v6.
>
> See https://www.spinics.net/lists/devicetree/msg173138.html
Hum, I see.

But still, if mvpwm->chip.base is 0, we will have an error in alloc_pwms():

in pmvebu_pwm_probe(), mvpwm->chip.base is set to 0 (kzalloc), then
pwmchip_add(&mvpwm->chip) is called,
which will call alloc_pwms(chip->base/* == 0 */, chip->npwm);
The 1st time (1st gpio bank), it will be ok because:
start = bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, from, count, 0);
if (pwm >= 0 && start != pwm)
     return -EEXIST;
start is 0, pwm is 0, everything is good.
BUT, on the second time (for gpio1), we will have start = 32 and pwm=0
=> -EEXIST !

So there's something to fix.
And It seems that setting mvpwm->chip.base to -1 is a good choice
since it doesn't
force the numbering to something already taken.


Regards;
Richard.
