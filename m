From: James Hartley <James.Hartley@imgtec.com>
Subject: Re: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC
 driver
Date: Mon, 24 Nov 2014 19:09:07 +0000
Message-ID: <1C907929-56BF-4FF7-9F64-866AA834090F@imgtec.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
	<1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
	<20141124101325.GB25912@ulmo.nvidia.com>
	<27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
	<20141124122807.GA4061@ulmo.nvidia.com>,<CAL1qeaH31ku6LTBV0HCDxzq+_gKWKeJR-4Gu+6dXkPU+FWvEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:7099 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbaKXTJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 14:09:11 -0500
In-Reply-To: <CAL1qeaH31ku6LTBV0HCDxzq+_gKWKeJR-4Gu+6dXkPU+FWvEaQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>, "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>




On 24 Nov 2014, at 18:19, Andrew Bresticker <abrestic@chromium.org> wrote:

>>>>> +     val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
>>>>> +     val |= BIT(pwm->hwpwm);
>>>>> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
>>>>> +
>>>>> +     regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
>>>>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
>>>>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);
>>> 
>>>> This smells like pinmux and should probably be a separate driver.
>>> 
>>> Hope you are suggesting us to have a separate driver for pin muxing (might already have one for Pistachio)
>>> and call the pin muxing driver APIs from here.
>>> 
>>> Please correct me if my understanding is wrong?
>> 
>> I don't think you need to call the pinmux API from here. Rather I'll
>> assume that the muxing is fixed on a given board, so this configuration
>> would be part of the static board-level pinmux so it will automatically
>> be applied at boot time.
> 
> The issue here is that this register does not belong to the
> pinmux/pinctrl block on this SoC and instead is part of the
> "peripheral control" block which primarily provides system interface
> gate clocks and resets (for which I was planning to write a clock
> provider driver), but also has a bunch of control registers for
> various IP blocks thrown together (like this one) which we're using
> syscon to access.  I'm not sure it makes sense to create a pinmux
> driver for these 4 bits, but I'll defer to others on that...
> 
> Another option would be to have the main pinctrl driver for Pistachio
> control these bits, but that doesn't seem quite right since these bits
> are completely separate from the pinctrl block.

I would think the pinctrl driver should deal with this - yes it's a separate set of registers, but the config is expected to be static and can be represented in the DT.

James. 