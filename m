From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Mon, 24 Nov 2014 09:47:41 -0800
Message-ID: <CAL1qeaEWawDwSP-GT_7EgMFHSq3SAAcbqDyxaD1b30AxMco5Cg@mail.gmail.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
	<1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
	<20141124101325.GB25912@ulmo.nvidia.com>
	<27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:54960 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbaKXRrl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 12:47:41 -0500
Received: by mail-vc0-f182.google.com with SMTP id hq12so2647145vcb.41
        for <linux-pwm@vger.kernel.org>; Mon, 24 Nov 2014 09:47:41 -0800 (PST)
In-Reply-To: <27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

>>> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> [...]
>>> +/* PWM registers */
>>> +#define CR_PWM_CTRL_CFG                              0x0000
>>> +#define CR_PWM_CTRL_CFG_NO_SUB_DIV           0
>>> +#define CR_PWM_CTRL_CFG_SUB_DIV0             1
>>> +#define CR_PWM_CTRL_CFG_SUB_DIV1             2
>>> +#define CR_PWM_CTRL_CFG_SUB_DIV0_DIV1                3
>>> +#define CR_PWM_CTRL_CFG_DIV_SHIFT(ch)                ((ch) * 2 + 4)
>>> +#define CR_PWM_CTRL_CFG_DIV_MASK             0x3
>>> +
>>> +#define CR_PWM_CH_CFG(ch)                    (0x4 + (ch) * 4)
>>> +#define CR_PWM_CH_CFG_TMBASE_SHIFT           0
>>> +#define CR_PWM_CH_CFG_DUTY_SHIFT             16
>
>> What's with the CR_ prefix here? What does it stand for? Can't you just
>> drop it?
>
> CR stands for Control Register. We have picked it from the datasheet and wanted to make the
> register names compatible with the same in the datasheet.
>
> Hope Andrew agrees with Thierry's comments here. Hope we can drop it.
>
> Andrew, any comments here, please.

I didn't think the CR_ prefix was totally necessary, but it matches
what's in the TRM, so I didn't have an issue with it.  I'm fine with
dropping it.
