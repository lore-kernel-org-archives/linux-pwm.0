From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
Date: Wed, 17 Jan 2018 10:29:53 +0200
Message-ID: <c2078487-8cc6-429e-6c38-092d776c33aa@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
 <20180112183122.GA102880@google.com>
 <61b85600-7aee-e9d1-6587-17e5e419b03a@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:2955 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeAQI37 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Jan 2018 03:29:59 -0500
In-Reply-To: <61b85600-7aee-e9d1-6587-17e5e419b03a@microchip.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, corbet@lwn.net, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, thierry.reding@gmail.com, alexandre.belloni@free-electrons.com, haojian.zhuang@gmail.com, linux-amlogic@lists.infradead.org, robert.jarzmik@free.fr, daniel@zonque.org, linux-arm-kernel@lists.infradead.org



On 15.01.2018 11:01, Claudiu Beznea wrote:
> 
> 
> On 12.01.2018 20:31, Brian Norris wrote:
>> On Fri, Jan 12, 2018 at 04:22:50PM +0200, Claudiu Beznea wrote:
>>> pwm-cells should be at least 2 to provide channel number and period value.
>>
>> Nacked-by: Brian Norris <briannorris@chromium.org>
>>
>> We don't control the period from the kernel; only the duty cycle.
> I agree, I saw this in the driver. This is the way I put the 0xffff
> period in the patch 7 of this series. I though that since all the drivers
> which uses PWM framework uses the generic PWM bindings (except pwm-pxa.c,
> pwm-cros-ec.c and pwm-clps711x.c) I though it would be simpler (from the
> driver's perspective and also from core's perspective) to have generic
> bindings for all as follows:
> pwms = <&controller PWM-channel PWM-period PWM-flags>;
> 
> To allow pwm-cross-ec.c to use this generic binding, since it is uses a
> fix period and of_pwm_xlate() xlate DT arguments without taking care of
> the cross-ec particularity, using 0xffff period in the pwms binding will
> not harm this driver (correct me if I'm wrong). For this, the pwm-cells
> argument need to be increased at 2. In patch 7 of this series I used
> pwms = <&cros_ec_pwm 1 65535>;
> which initialize the PWM 1 with 0xffff period.
> 
> Thanks,
> Claudiu
> 
> (Now,
>> that's perhaps not a wise firmware interface, and we may fix that
>> someday, but you can't just declare a breaking change to a documented,
>> reviewed binding.
>>
>>> Cc: Brian Norris <briannorris@chromium.org>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>>  Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>>> index 472bd46ab5a4..03347fd302b5 100644
>>> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>>> @@ -8,7 +8,7 @@ Documentation/devicetree/bindings/mfd/cros-ec.txt).
>>>  
>>>  Required properties:
>>>  - compatible: Must contain "google,cros-ec-pwm"
>>> -- #pwm-cells: Should be 1. The cell specifies the PWM index.
>>> +- #pwm-cells: Should be 2. The cell specifies the PWM index.
>>
>> Umm, "2 cells", but you use the singular "cell", and don't document what
>> the second one is? That's nonsense.
I didn't saw this comment. The second cell is from the standard PWM binding
as all the other PWM drivers uses. e.g.:
pwms=<&controller PWM-channel PWM-period PWM-flags>

With these changes, if pwm-cells=1 then only PWM-channel will be parsed,
if it is 2 PWM-channel and PWM-period will be parsed, if pwm-cells=3
then PWM-channel, PWM-period and PWM-flags will be parsed.
In your driver you used to have only one cell because you wanted to allow
user to give as argument only PWM channel, and you did not want a change
of PWM period (and in of_xlate function you initialize pwm period with 0xffff
value: this is why I changed the binding in patch 7 of this series, file
rk3399-gru-kevin.dts). But e.g. sysfs could try to change the PWM period,
there is no restriction to change the PWM period from sysfs, in the sysfs
interface but the restriction is in PWM apply of the drive. The same things
happens with these changes too. The user could introduce any PWM period via
DT but the pwm apply function of the driver will return error.

Thanks,
Claudiu

>>
>> Brian
>>
>>>  
>>>  Example:
>>>  	cros-ec@0 {
>>> @@ -18,6 +18,6 @@ Example:
>>>  
>>>  		cros_ec_pwm: ec-pwm {
>>>  			compatible = "google,cros-ec-pwm";
>>> -			#pwm-cells = <1>;
>>> +			#pwm-cells = <2>;
>>>  		};
>>>  	};
>>> -- 
>>> 2.7.4
>>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
