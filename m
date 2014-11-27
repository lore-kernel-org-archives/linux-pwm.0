From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: RE: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC
 driver
Date: Thu, 27 Nov 2014 16:03:57 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F53597A@hbmail01.hb.imgtec.org>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
	<1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
	<20141124101325.GB25912@ulmo.nvidia.com>
	<27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
	<20141124122807.GA4061@ulmo.nvidia.com>,<CAL1qeaH31ku6LTBV0HCDxzq+_gKWKeJR-4Gu+6dXkPU+FWvEaQ@mail.gmail.com>,<1C907929-56BF-4FF7-9F64-866AA834090F@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:31643 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaK0QEE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Nov 2014 11:04:04 -0500
In-Reply-To: <1C907929-56BF-4FF7-9F64-866AA834090F@imgtec.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: James Hartley <James.Hartley@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

Hi James, Andrew, Thierry and all,


> On 24 Nov 2014, at 18:19, Andrew Bresticker <abrestic@chromium.org> wrote:

>>>>>> +     val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
>>>>>> +     val |= BIT(pwm->hwpwm);
>>>>>> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
>>>>>> +
>>>>>> +     regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
>>>>>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
>>>>>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);
>>>>
>>>>> This smells like pinmux and should probably be a separate driver.
>>>>
>>>> Hope you are suggesting us to have a separate driver for pin muxing (might already have one for Pistachio)
>>>> and call the pin muxing driver APIs from here.
>>>>
>>>> Please correct me if my understanding is wrong?
>>>
>>> I don't think you need to call the pinmux API from here. Rather I'll
>>> assume that the muxing is fixed on a given board, so this configuration
>>> would be part of the static board-level pinmux so it will automatically
>>> be applied at boot time.
>>
>> The issue here is that this register does not belong to the
>> pinmux/pinctrl block on this SoC and instead is part of the
>> "peripheral control" block which primarily provides system interface
>> gate clocks and resets (for which I was planning to write a clock
>> provider driver), but also has a bunch of control registers for
>> various IP blocks thrown together (like this one) which we're using
>> syscon to access.  I'm not sure it makes sense to create a pinmux
>> driver for these 4 bits, but I'll defer to others on that...
>>
>> Another option would be to have the main pinctrl driver for Pistachio
>> control these bits, but that doesn't seem quite right since these bits
>> are completely separate from the pinctrl block.

> I would think the pinctrl driver should deal with this - yes it's a separate set of registers,
> but the config is expected to be static and can be represented in the DT.

> James.

I have discussed with the hardware team one more time today and discovered that
the value we configure to CR_PERIP_PWM_PDM_CONTROL not only configures PWM/PDM
output mux, but also enables control signal for PDM blocks.

As an example, if the PDM user wants to enable PDM block 2, he needs to set bit 8 to 1 in the
register CR_PERIP_PWM_PDM_CONTROL. Please also note that setting bit 8  to 1 not only
configures the output PWM/PDM mux, but also enables control signal for PDM block 2.
He needs access to this register from the PDM driver at least to configure (enable/disable)
PDM control signal.

And also because of the reasons explained by Andrew above, I think it is better to use syscon
(instead of handling it in Pinctrl driver) to access this register both in PWM and PDM drivers.

Please let us know comments and suggestions.

Thanks and regards,
Naidu.



