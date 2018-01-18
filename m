From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
Date: Thu, 18 Jan 2018 11:18:02 +0200
Message-ID: <48829251-ef9a-1566-9a69-9e66ce64c232@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
 <20180112183122.GA102880@google.com>
 <61b85600-7aee-e9d1-6587-17e5e419b03a@microchip.com>
 <c2078487-8cc6-429e-6c38-092d776c33aa@microchip.com>
 <20180117231056.GB112833@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:63825 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeARJSG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jan 2018 04:18:06 -0500
In-Reply-To: <20180117231056.GB112833@google.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, corbet@lwn.net, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, thierry.reding@gmail.com, alexandre.belloni@free-electrons.com, haojian.zhuang@gmail.com, linux-amlogic@lists.infradead.org, robert.jarzmik@free.fr, daniel@zonque.org, linux-arm-kernel@lists.infradead.org



On 18.01.2018 01:10, Brian Norris wrote:
> On Wed, Jan 17, 2018 at 10:29:53AM +0200, Claudiu Beznea wrote:
>> With these changes, if pwm-cells=1 then only PWM-channel will be parsed,
> 
> I'm not sure if I'm understanding you correctly but...no. If cells is 1,
> then your driver change just causes us not to parse correctly, and
> everything fails.
My bad, agree with you, will fail with pwm-cells=1. I forgot about:
+	if (args->args_count < PWM_ARGS_CNT_XLATE_PERIOD ||
+	    args->args_count > PWM_ARGS_CNT_XLATE_MAX)
 		return ERR_PTR(-EINVAL);
restriction.

> 
>> if it is 2 PWM-channel and PWM-period will be parsed, if pwm-cells=3
>> then PWM-channel, PWM-period and PWM-flags will be parsed.
>> In your driver you used to have only one cell because you wanted to allow
>> user to give as argument only PWM channel, and you did not want a change
>> of PWM period (and in of_xlate function you initialize pwm period with 0xffff
>> value: this is why I changed the binding in patch 7 of this series, file
> 
> It's not a matter of "allow", it's a matter of description. The period
> isn't actually even 0xffff, that's just a pseudo-period, to reflect that
> you have a choice of duty cycles of 0 to 0xffff. I (justifiably, I
> think) didn't think putting this false value in the device tree was
> accurate.
Ok, I didn't investigate the driver to see what is truly set in HW.
> 
>> rk3399-gru-kevin.dts). But e.g. sysfs could try to change the PWM period,
>> there is no restriction to change the PWM period from sysfs, in the sysfs
>> interface but the restriction is in PWM apply of the drive. The same things
>> happens with these changes too. The user could introduce any PWM period via
>> DT but the pwm apply function of the driver will return error.
> 
> sysfs has no bearing on a device tree binding. Just because we have a
> broken interface here doesn't mean we should change how we describe the
> hardware.
> 
Based on [1] and the comments I will drop the first 7 patches of this series.

Thanks,
Claudiu 

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt
> Brian
> 
