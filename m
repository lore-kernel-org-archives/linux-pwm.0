From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Mon, 24 Nov 2014 10:19:46 -0800
Message-ID: <CAL1qeaH31ku6LTBV0HCDxzq+_gKWKeJR-4Gu+6dXkPU+FWvEaQ@mail.gmail.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
	<1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
	<20141124101325.GB25912@ulmo.nvidia.com>
	<27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
	<20141124122807.GA4061@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:64744 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaKXSTr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 13:19:47 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so3819494vcb.29
        for <linux-pwm@vger.kernel.org>; Mon, 24 Nov 2014 10:19:46 -0800 (PST)
In-Reply-To: <20141124122807.GA4061@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>, "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

>> >> +     val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
>> >> +     val |= BIT(pwm->hwpwm);
>> >> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
>> >> +
>> >> +     regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
>> >> +                        CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
>> >> +                        CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);
>>
>> > This smells like pinmux and should probably be a separate driver.
>>
>> Hope you are suggesting us to have a separate driver for pin muxing (might already have one for Pistachio)
>> and call the pin muxing driver APIs from here.
>>
>> Please correct me if my understanding is wrong?
>
> I don't think you need to call the pinmux API from here. Rather I'll
> assume that the muxing is fixed on a given board, so this configuration
> would be part of the static board-level pinmux so it will automatically
> be applied at boot time.

The issue here is that this register does not belong to the
pinmux/pinctrl block on this SoC and instead is part of the
"peripheral control" block which primarily provides system interface
gate clocks and resets (for which I was planning to write a clock
provider driver), but also has a bunch of control registers for
various IP blocks thrown together (like this one) which we're using
syscon to access.  I'm not sure it makes sense to create a pinmux
driver for these 4 bits, but I'll defer to others on that...

Another option would be to have the main pinctrl driver for Pistachio
control these bits, but that doesn't seem quite right since these bits
are completely separate from the pinctrl block.
