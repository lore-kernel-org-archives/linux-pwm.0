From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us property
Date: Thu, 6 Jul 2017 10:26:38 +0200
Message-ID: <CAFqH_50r5+tCU+Bh6TVnf-R1XNa=QxEjXH9Ypuc5yVdAhBgpxA@mail.gmail.com>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com> <20170706081322.GM16144@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33624 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdGFI0k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 04:26:40 -0400
In-Reply-To: <20170706081322.GM16144@ulmo.fritz.box>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>

Hi Thierry,

Many thanks for your comments, I'll send a v3.

2017-07-06 10:13 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wrote:
>> From: huang lin <hl@rock-chips.com>
>>
>> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
>> request a delay between set the PWM signal and enable the backlight and
>> between clear the PWM signal and disable the backlight. Add support for
>> the new pwm-delay-us property to meet the timing.
>>
>> Note that this patch inverts current sequence. Before this patch the
>> enable signal was set before the PWM signal and vice-versa on power off.
>>
>> I assumed that this sequence was wrong, at least it is on different panel
>> datasheets that I checked, so I inverted the sequence to follow:
>>
>>   On power on, set the PWM signal, wait, and set the LED_EN signal.
>>   On power off, clear the LED_EN signal, wait, and stop the PWM signal.
>>
>> Signed-off-by: huang lin <hl@rock-chips.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>> Changes since v1:
>>  - As suggested by Daniel Thompson
>>    - Do not assume power-on delay and power-off delay will be the same
>>  - Move the check of dt property to the parse dt function.
>>
>> v1: https://lkml.org/lkml/2017/6/28/219
>>
>>  drivers/video/backlight/pwm_bl.c | 24 ++++++++++++++++++++----
>>  include/linux/pwm_backlight.h    |  1 +
>>  2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 002f1ce..0f5470e 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -10,6 +10,7 @@
>>   * published by the Free Software Foundation.
>>   */
>>
>> +#include <linux/delay.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/gpio.h>
>>  #include <linux/module.h>
>> @@ -35,6 +36,7 @@ struct pwm_bl_data {
>>       struct gpio_desc        *enable_gpio;
>>       unsigned int            scale;
>>       bool                    legacy;
>> +     unsigned int            pwm_delay[2];
>>       int                     (*notify)(struct device *,
>>                                         int brightness);
>>       void                    (*notify_after)(struct device *,
>> @@ -54,10 +56,14 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>>       if (err < 0)
>>               dev_err(pb->dev, "failed to enable power supply\n");
>>
>> +     pwm_enable(pb->pwm);
>> +
>> +     if (pb->pwm_delay[0])
>> +             usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] + 2000);
>> +
>>       if (pb->enable_gpio)
>>               gpiod_set_value_cansleep(pb->enable_gpio, 1);
>>
>> -     pwm_enable(pb->pwm);
>>       pb->enabled = true;
>>  }
>>
>> @@ -66,12 +72,15 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>       if (!pb->enabled)
>>               return;
>>
>> -     pwm_config(pb->pwm, 0, pb->period);
>> -     pwm_disable(pb->pwm);
>> -
>>       if (pb->enable_gpio)
>>               gpiod_set_value_cansleep(pb->enable_gpio, 0);
>>
>> +     if (pb->pwm_delay[1])
>> +             usleep_range(pb->pwm_delay[1], pb->pwm_delay[1] + 2000);
>> +
>> +     pwm_config(pb->pwm, 0, pb->period);
>> +     pwm_disable(pb->pwm);
>> +
>>       regulator_disable(pb->power_supply);
>>       pb->enabled = false;
>>  }
>> @@ -174,6 +183,12 @@ static int pwm_backlight_parse_dt(struct device *dev,
>>               data->max_brightness--;
>>       }
>>
>> +     /* read pwm to enable pre/post delays from DT property */
>> +     ret = of_property_read_u32_array(node, "pwm-delay-us", data->pwm_delay,
>> +                                      ARRAY_SIZE(data->pwm_delay));
>> +     if (ret < 0)
>> +             return ret;
>
> Also I think you need to make sure you have a fallback in place in case
> that this fails, otherwise the property is no longer optional.
>
> Ignoring -EINVAL should do the trick since data->pwm_delay should be
> zeroed out by the memset() earlier in this function.
>

Yep, you have reason. Thanks.


> Thierry
