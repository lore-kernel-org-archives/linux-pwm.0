From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH v2 0/6] Support PWM polarity control
Date: Wed, 05 Oct 2016 09:50:27 -0700
Message-ID: <be9c9f6b22788ca4d9c9243a46932945@agner.ch>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
 <20161004094805.466ebc6d@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161004094805.466ebc6d@jawa>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>
Cc: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Lukasz,

On 2016-10-04 00:48, Lukasz Majewski wrote:
> Dear Bhuvanchandra,
> 
> Thank you for your effort to send those patches to ML.
> 
>> Changes since v2:
>>
>> - Picked the stalled patchset[1] from Lothar Wassmann which adds the
>> basic support for polarity control on imx-pwm driver and adds
>> backward compatibility support for devices which does not have
>> polarity control feature.
>>
>> Changes since Lothars v6:
>>
>> - Squash Lukasz patch[2].
>>
>> [1] http://thread.gmane.org/gmane.linux.pwm/1621
>> [2] https://www.spinics.net/lists/arm-kernel/msg530818.html
>>
>> Bhuvanchandra DV (3):
>>   arm: dts: imx7: Update #pwm-cells for PWM polarity control
>>   arm: dts: imx7-colibri: Use pwm polarity control
>>   arm: dts: imx7-colibri: Use enable-gpios for BL_ON
>>
>> Lothar Wassmann (3):
>>   pwm: print error messages with pr_err() instead of pr_debug()
>>   pwm: core: make the PWM_POLARITY flag in DTB optional
>>   pwm: imx: support output polarity inversion
> 
> For some reason this patchset works differently than the one developed
> by Lothar.
> 
> The difference is with the brightness level control.
> 
> My brightness definition in DTS:
> 
>            pwms = <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;
> 
>  		brightness-levels = <  0   1   2   3   4   5   6   7   8   9
> 
> 					 ..  ............
> 				    250 251 252 253 254 255>;
> 		default-brightness-level = <50>;
> 		enable-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> 

If you are using something else than i.MX 7 you also want to update the
SoC level device tree, specifically change the pwm-cells property:
#pwm-cells = <3>;


> When I go to the backlight sysfs entry:
> 
> cd /sys/devices/soc0/backlight/backlight/backlight
> 
> It seems like the brightness level control is inverted - i.e. 
> 'echo 20 > brightness" makes picture on the screen very bright, and 
> 'echo 200 > brightness' makes the picture diminish.
> 
> With my "internal" patches the situation is opposite (and I've checked it with
> my HW connections).

Just to check whether the driver actually applies the polarity you can
add a #define DEBUG at the top of the driver (drivers/pwm/pwm-imx.c) and
pass ignore_loglevel as kernel command line. This should give you "PWM
supports output inversion" at startup and a "... polarity set to .."
message whenever the polarity is set.

--
Stefan

> 
> Could you check on your setup if similar situation takes place? I mean
> if the brightness control works as expected?
> 
> Thanks in advance,
> Łukasz Majewski
> 
>>
>>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
>>  arch/arm/boot/dts/imx7-colibri.dtsi               | 12 +++++-
>>  arch/arm/boot/dts/imx7s.dtsi                      |  8 ++--
>>  drivers/pwm/core.c                                | 31 ++++++++------
>>  drivers/pwm/pwm-imx.c                             | 51
>> +++++++++++++++++++++-- 5 files changed, 83 insertions(+), 25
>> deletions(-)
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
