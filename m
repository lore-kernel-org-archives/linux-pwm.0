From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: RE: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC
 driver
Date: Mon, 24 Nov 2014 14:19:02 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F5303E3@hbmail01.hb.imgtec.org>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>
 <20141124101325.GB25912@ulmo.nvidia.com>
 <27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>,<20141124122807.GA4061@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:53455 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbaKXOTJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 09:19:09 -0500
In-Reply-To: <20141124122807.GA4061@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

Hi James,

> On Mon, Nov 24, 2014 at 11:22:31AM +0000, Naidu Tellapati wrote:
>> Hi Thierry,
>>
>> Many thanks for the review.
>>
>> > On Sat, Nov 22, 2014 at 07:23:29AM +0530, naidu.tellapati@gmail.com wrote:
>> >> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> >>
>> >> The Pistachio SOC from Imagination Technologies includes a Pulse Width
>> >> Modulation DAC which produces 1 to 4 digital bit-outputs which represent
>> >> digital waveforms. These PWM outputs are primarily in charge of controlling
>> >> backlight LED devices.
>> >>
>> >> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> >> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
>> >> ---
>>> >>  drivers/pwm/Kconfig   |   12 ++
>> >>  drivers/pwm/Makefile  |    1 +
>> >>  drivers/pwm/pwm-img.c |  270 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 283 insertions(+), 0 deletions(-)
>> >>  create mode 100644 drivers/pwm/pwm-img.c
>> >>
>> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> >> index ef2dd2e..6b4581a 100644
>> >> --- a/drivers/pwm/Kconfig
>> >> +++ b/drivers/pwm/Kconfig
>> >> @@ -110,6 +110,18 @@ config PWM_FSL_FTM
>> >>         To compile this driver as a module, choose M here: the module
>> >>         will be called pwm-fsl-ftm.
>> >>
>> >> +config PWM_IMG
>>
>> > This sounds really generic to me. Basically this says that every PWM IP
>> > developed by Imagination Technologies will be compatible with this one.
>> > It's typical to name modules after <vendor>-<soc> to avoid this type of
>> > ambiguity.
>>
>> > Is there any reason why this can't be called PWM_IMG_PISTACHIO?
>>
>> At this moment, this IP Block is available at least on one more SOC from Imagination Technologies.
>> It is possible that the IP will be available on more SOCs in future.
>>
>> Shall we go ahead with PWM_IMG?

> Alright, if ever there's a different PWM IP block from Imagination
> Technologies, the driver for that can have a more specific name.

>> >> +
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

> I don't think you need to call the pinmux API from here. Rather I'll
> assume that the muxing is fixed on a given board, so this configuration
> would be part of the static board-level pinmux so it will automatically
> be applied at boot time.

Could you please suggest us on the output pin muxing between PWM & PDM.

As of now we are configuring the mux control register from the PWM & PDM drivers.

Regards,
Naidu.