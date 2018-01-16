From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
Date: Tue, 16 Jan 2018 11:33:08 +0200
Message-ID: <a15b3974-33ca-70c9-2579-bcdd0d9eb5b1@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <d657c681-da16-712d-0570-8c05c6bfd550@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9651 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeAPJdO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Jan 2018 04:33:14 -0500
In-Reply-To: <d657c681-da16-712d-0570-8c05c6bfd550@baylibre.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, Mike Dunn <mikedunn@newsguy.com>, Alexander Shiyan <shc_work@mail.ru>, devicetree@vger.kernel.org, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org



On 16.01.2018 11:07, Neil Armstrong wrote:
> On 12/01/2018 15:22, Claudiu Beznea wrote:
>> Remove of_pwm_simple_xlate() and of_pwm_xlate_with_flags() functions
>> and add of_pwm_xlate() which is used in all cases no mather if the OF
>> bindings are with PWM flags or not. This should not affect the old
>> behavior since the xlate will be based on #pwm-cells property of the
>> PWM controller. Based on #pwm-cells property the xlate will consider
>> the flags or not. This will permit the addition of other inputs to OF
>> xlate by just adding proper code at the end of of_pwm_xlate() and a new
>> input to enum pwm_args_xlate_options. With this changes there will be
>> no need to fill of_xlate and of_pwm_n_cells of struct pwm_chip from
>> the drivers probe methods. References in drives to references to of_xlate
>> and of_pwm_n_cells were removed. Drivers which used private of_xlate
>> functions switched to the generic of_pwm_xlate() function which fits
>> for it but with little changes in device trees (these drivers translated
>> differently the "pwms" bindings; the "pwms" bindings now are generic to
>> all drivers and all drivers should provide them in the format described
>> in pwm documentation).
>>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Mike Dunn <mikedunn@newsguy.com>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Alexander Shiyan <shc_work@mail.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>
>> This patch (and the next 7) could be applied independetly by this series, if
>> any, but I choosed to have it here since it makes easy the PWM modes parsing.
>> If you feel it could be independently of this series I could send a new version.
>>
>> Also, Thierry, Mike, Brian, Shiyan, please take an extra look over pwm-pxa.c,
>> pwm-cros-ec.c and pwm-clps711x.c since these were moved to use the generic
>> pwms (minimum 2 pwm-cells).
>>
>>  drivers/pwm/core.c             | 56 +++++++++++-------------------------------
>>  drivers/pwm/pwm-atmel-hlcdc.c  |  2 --
>>  drivers/pwm/pwm-atmel-tcb.c    |  2 --
>>  drivers/pwm/pwm-atmel.c        |  6 -----
>>  drivers/pwm/pwm-bcm-iproc.c    |  2 --
>>  drivers/pwm/pwm-bcm-kona.c     |  2 --
>>  drivers/pwm/pwm-bcm2835.c      |  2 --
>>  drivers/pwm/pwm-berlin.c       |  2 --
>>  drivers/pwm/pwm-clps711x.c     | 11 ---------
>>  drivers/pwm/pwm-cros-ec.c      | 20 ---------------
>>  drivers/pwm/pwm-fsl-ftm.c      |  2 --
>>  drivers/pwm/pwm-hibvt.c        |  2 --
>>  drivers/pwm/pwm-imx.c          |  8 ------
>>  drivers/pwm/pwm-lpc18xx-sct.c  |  2 --
>>  drivers/pwm/pwm-meson.c        |  2 --
>>  drivers/pwm/pwm-omap-dmtimer.c |  2 --
>>  drivers/pwm/pwm-pxa.c          | 19 --------------
>>  drivers/pwm/pwm-renesas-tpu.c  |  2 --
>>  drivers/pwm/pwm-rockchip.c     |  5 ----
>>  drivers/pwm/pwm-samsung.c      |  3 ---
>>  drivers/pwm/pwm-sun4i.c        |  2 --
>>  drivers/pwm/pwm-tiecap.c       |  2 --
>>  drivers/pwm/pwm-tiehrpwm.c     |  2 --
>>  drivers/pwm/pwm-vt8500.c       |  2 --
>>  drivers/pwm/pwm-zx.c           |  2 --
>>  include/linux/pwm.h            | 23 ++++++++++-------
>>  26 files changed, 29 insertions(+), 156 deletions(-)
>>
> 
> [...]
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 0767deba8e62..6702fcc203ce 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -535,8 +535,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
>>  	meson->chip.ops = &meson_pwm_ops;
>>  	meson->chip.base = -1;
>>  	meson->chip.npwm = 2;
>> -	meson->chip.of_xlate = of_pwm_xlate_with_flags;
>> -	meson->chip.of_pwm_n_cells = 3;
>>  
>>  	meson->data = of_device_get_match_data(&pdev->dev);
>>  	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index 5ad42f33e70c..6bd32ae6dd3e 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -317,8 +317,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>  	omap->chip.ops = &pwm_omap_dmtimer_ops;
>>  	omap->chip.base = -1;
>>  	omap->chip.npwm = 1;
>> -	omap->chip.of_xlate = of_pwm_xlate_with_flags;
>> -	omap->chip.of_pwm_n_cells = 3;
>>  
>>  	mutex_init(&omap->mutex);
>>  
> [...]
> 
> Hi Claudiu,
> 
> Please avoid changing the device tree plumbing, this of_xlate fields are needed since
> some platforms will need to have their own translate functions.
> 
> Moving a to single mandatory xlate function is going backward, a possible move
> would be to default to of_pwm_xlate_with_flags and 3 cells if of_xlate is NULL,
> or use the platforms xlate if provided.
> 
> Moving to a single xlate function is unrelated to your needs and can break some platforms.

Hi Neil,

Thank you for your feedback. Looking over the drivers I saw that only 3 drivers
are using private of_xlate functions, the rest of them uses of_pwm_xlate_with_flags
and of_pwm_simple_xlate function combined with pwm-cells binding and of_pwm_n_cells
(which I think is redundant with pwm-cells). I though that switching to a common
of_xlate to xlate everything based on pwm-cells binding value would be better
and remove redundant code.

But if this is a downward direction I agree to drop the changes related to of_xlate.

Thanks,
Claudiu

> 
> Neil
> 
