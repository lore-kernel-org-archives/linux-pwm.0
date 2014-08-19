From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/4] pwm: rockchip: Allow polarity invert on rk3288
Date: Tue, 19 Aug 2014 09:05:20 -0700
Message-ID: <CAD=FV=Uvx3PMJRdnm4FKWWx4h3sN0Mn1yG6v245HnKur_3vgqQ@mail.gmail.com>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
	<1408381749-14156-3-git-send-email-dianders@chromium.org>
	<20140819071857.GD12859@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:58868 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbaHSQFV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Aug 2014 12:05:21 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so7726992vcb.30
        for <linux-pwm@vger.kernel.org>; Tue, 19 Aug 2014 09:05:20 -0700 (PDT)
In-Reply-To: <20140819071857.GD12859@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Caesar Wang <caesar.wang@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, Olof Johansson <olof@lixom.net>, Eddie Cai <eddie.cai@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Thierry

On Tue, Aug 19, 2014 at 12:18 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Aug 18, 2014 at 10:09:07AM -0700, Doug Anderson wrote:
> [...]
>> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
>>  #define PWM_LP_DISABLE               (0 << 8)
>>
>> @@ -32,6 +34,7 @@ struct rockchip_pwm_chip {
>>       struct pwm_chip chip;
>>       struct clk *clk;
>>       const struct rockchip_pwm_data *data;
>> +     enum pwm_polarity polarity;
>
> Why do you need this field? struct pwm_device already has a copy of it.

OK, good point.


>> @@ -74,10 +78,14 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
>>  {
>>       struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>>       u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
>> -                       PWM_CONTINUOUS | PWM_DUTY_POSITIVE |
>> -                       PWM_INACTIVE_NEGATIVE;
>> +                       PWM_CONTINUOUS;
>>       u32 val;
>>
>> +     if (pc->polarity == PWM_POLARITY_INVERSED)
>> +             enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
>> +     else
>> +             enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
>
> I have a feeling you're going to answer the above question with: "Because
> it's needed here". If so, my reply would be: "Then this function should
> take a struct pwm_device instead of struct pwm_chip."

OK.  I've chosen to have it take a pwm_device AND a pwm_chip.  It is a
little redundant because a pwm_device has a pointer to its pwm_chip,
but it follows the lead of all of the callbacks in "struct pwm_ops".
If you'd like me to spin it to take only a pwm_device I'm happy to.


>
>> @@ -173,6 +195,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
>>               .ctrl = 0x0c,
>>       },
>>       .prescaler = 1,
>> +     .has_invert = 1,
>
> Since has_invert is a boolean, the proper value here would be "true".

Done.


>> @@ -228,6 +252,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>>       pc->data = id->data;
>>       pc->chip.dev = &pdev->dev;
>>       pc->chip.ops = &rockchip_pwm_ops;
>> +     if (pc->data->has_invert) {
>> +             pc->chip.of_xlate = of_pwm_xlate_with_flags;
>> +             pc->chip.of_pwm_n_cells = 3;
>> +     }
>>       pc->chip.base = -1;
>>       pc->chip.npwm = 1;
>
> I suggest to rewrite the above as follows for readability:
>
>         pc->data = id->data;
>         pc->chip.dev = &pdev->dev;
>         pc->chip.ops = &rockchip_pwm_ops;
>         pc->chip.base = -1;
>         pc->chip.npwm = 1;

Done.


> +       if (pc->data->has_invert) {
> +               pc->chip.of_xlate = of_pwm_xlate_with_flags;
> +               pc->chip.of_pwm_n_cells = 3;
> +       }
>
> Thierry
