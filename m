From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Thu, 13 Nov 2014 11:03:08 -0800
Message-ID: <CAL1qeaF2Dz0W4qAW=A_GYVBNur4mhjeM61X66cduf5VX9t5HbQ@mail.gmail.com>
References: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415795873-4816-2-git-send-email-Naidu.Tellapati@imgtec.com>
	<CAL1qeaFuKccak4fJFOK1YSW1uoyLA_a=GFWJ1PTS00Ab9vZB9A@mail.gmail.com>
	<1F66364AC115084B902937EE750BD69B3F145947@hbmail01.hb.imgtec.org>
	<1F66364AC115084B902937EE750BD69B3F14598A@hbmail01.hb.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61549 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933146AbaKMTDJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Nov 2014 14:03:09 -0500
Received: by mail-vc0-f174.google.com with SMTP id la4so4099538vcb.19
        for <linux-pwm@vger.kernel.org>; Thu, 13 Nov 2014 11:03:08 -0800 (PST)
In-Reply-To: <1F66364AC115084B902937EE750BD69B3F14598A@hbmail01.hb.imgtec.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sai Masarapu <Sai.Masarapu@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>, Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Nov 13, 2014 at 5:55 AM, Sai Masarapu <Sai.Masarapu@imgtec.com> wrote:
> On Wed, Nov 12, 2014 at 4:37 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>>> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>>
>>> The Pistachio SOC from Imagination Technologies includes a Pulse
>>> Width Modulation DAC which produces 1 to 4 digital bit-outputs which
>>> represent digital waveforms. These PWM outputs are primarily in
>>> charge of controlling backlight LED devices.
>>>
>>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>

>>> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c new file
>>> mode 100755 index 0000000..9361dbf

>>> +#define CR_PERIP_PWM_PDM_CONTROL       0x0140 /* PWM and PDM ctrl register */
>>> +#define PWM_PDM_CH_CTRL_SHIFT(ch)      (ch * 4)
>>> +
>>> +#define NUM_PWM                                4
>>> +#define SUB_DIV0                       1
>>> +#define SUB_DIV1                       2
>>> +#define NO_SUB_DIV                     0
>>> +#define SUB_DIV0_DIV1                  3
>>> +#define MIN_TMBASE_STEPS               1
>>> +#define MAX_TMBASE_STEPS               65536
>>> +#define MIN_DUTY_STEPS                 0
>>> +#define MAX_DUTY_STEPS                 65535
>
>> Please place these #defines next to their corresponding register or register field #define.
>
>    Defined Macros are not related to register fields.

Really?  The SUB_DIV #defines are possible values for the DIVIDER
field in CR_PWM_CTRL_CFG, are they not?  And I believe the TMBASE and
DUTY #defines specify the range of values for the DUTYCYCLE and
TIMEBASE fields of the CR_PWM*_CFG registers.
