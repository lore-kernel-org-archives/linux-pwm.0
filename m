From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] pwm: ab8500: Fix wrong value shift for disable/enable pwm
Date: Wed, 9 Apr 2014 21:18:20 +0800
Message-ID: <CAFRkauDLDhbd8MvEECxewduVfdsru1aCAhAORCE8cj5Zn7AgAA@mail.gmail.com>
References: <1387078339.22351.2.camel@phoenix>
	<20131217093049.GA13823@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:65516 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933002AbaDINSV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 09:18:21 -0400
Received: by mail-qc0-f177.google.com with SMTP id w7so2645436qcr.22
        for <linux-pwm@vger.kernel.org>; Wed, 09 Apr 2014 06:18:20 -0700 (PDT)
In-Reply-To: <20131217093049.GA13823@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org

2013-12-17 17:30 GMT+08:00 Thierry Reding <thierry.reding@gmail.com>:
> On Sun, Dec 15, 2013 at 11:32:19AM +0800, Axel Lin wrote:
> [...]
>
> s/pwm/PWM/ in the subject, please.
>
> [...]
>> @@ -64,7 +60,7 @@ static int ab8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>
>>       ret = abx500_mask_and_set_register_interruptible(chip->dev,
>>                               AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
>> -                             1 << (chip->base - 1), ENABLE_PWM);
>> +                             1 << (chip->base - 1), 1 << (chip->base - 1));
>
> I think we really need to find some other way to do this. At some point
> I imagine board will move to DT, at which point we can no longer rely on
> chip->base being set to a meaningful value.

Hi Thierry,

(I almost forgot this thread...)
I just check the code in drivers/mfd/ab8500-core.c.

In ab8500_devs[]:
        {
                .name = "ab8500-pwm",
                .of_compatible = "stericsson,ab8500-pwm",
                .id = 1,
        },
        {
                .name = "ab8500-pwm",
                .of_compatible = "stericsson,ab8500-pwm",
                .id = 2,
        },
        {
                .name = "ab8500-pwm",
                .of_compatible = "stericsson,ab8500-pwm",
                .id = 3,
        },

And in ab8500_pwm_probe():
        ab8500->chip.base = pdev->id;

My understanding is the chip->base setting is the same for DT and non-DT case.

(I'm not sure if you still have the patch, so I'm re-sending the patch now.)

Regards,
Axel
