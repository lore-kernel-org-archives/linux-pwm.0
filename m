From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Date: Thu, 20 Jul 2017 11:37:17 +0100
Message-ID: <38adad8d-754b-d1dd-167a-913afd8075d6@linaro.org>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
 <20170717212811.25374-3-enric.balletbo@collabora.com>
 <d38fa016-ea9c-edf8-9684-5c1235d27c82@linaro.org>
 <20170720080656.GC13103@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36929 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934409AbdGTKhU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2017 06:37:20 -0400
Received: by mail-wr0-f171.google.com with SMTP id 33so12436804wrz.4
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2017 03:37:19 -0700 (PDT)
In-Reply-To: <20170720080656.GC13103@amd>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org

On 20/07/17 09:06, Pavel Machek wrote:
> Hi!
> 
>>> --- a/drivers/video/backlight/pwm_bl.c
>>> +++ b/drivers/video/backlight/pwm_bl.c
>>> @@ -10,6 +10,7 @@
>>>    * published by the Free Software Foundation.
>>>    */
>>> +#include <linux/delay.h>
>>>   #include <linux/gpio/consumer.h>
>>>   #include <linux/gpio.h>
>>>   #include <linux/module.h>
>>> @@ -35,6 +36,7 @@ struct pwm_bl_data {
>>>   	struct gpio_desc	*enable_gpio;
>>>   	unsigned int		scale;
>>>   	bool			legacy;
>>> +	unsigned int		pwm_delay[2];
>>
>> Two named members would be better here (eliminating the "magic" 0
>> and 1).
> 
> My thought, too.
> 
>>> @@ -56,6 +58,9 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>>>   	pwm_enable(pb->pwm);
>>> +	if (pb->pwm_delay[0])
>>> +		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] * 2);
> 
> Plus I'd just do the delay unconditionally :-).

... does this still apply if this code is switched to msleep()?

msleep() has no wait avoidance[1] and if lots of drivers are reckless 
about sleeping for 10ms it soon starts to show up in the boot time 
(especially optimized ones).


Daniel.


[1] As it happens I can't see that many early bail out paths in
     usleep_range() either.
