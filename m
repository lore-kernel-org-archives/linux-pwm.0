From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: RE: [PATCH RESEND v4 1/4] pwm: Imagination Technologies PWM DAC
 driver
Date: Mon, 24 Nov 2014 11:22:31 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F52EE89@hbmail01.hb.imgtec.org>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1416621212-11701-2-git-send-email-Naidu.Tellapati@gmail.com>,<20141124101325.GB25912@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:55865 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaKXLWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 06:22:39 -0500
In-Reply-To: <20141124101325.GB25912@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>
Cc: "abrestic@chromium.org" <abrestic@chromium.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

Hi Thierry,

Many thanks for the review.

> On Sat, Nov 22, 2014 at 07:23:29AM +0530, naidu.tellapati@gmail.com wrote:
>> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>
>> The Pistachio SOC from Imagination Technologies includes a Pulse Width
>> Modulation DAC which produces 1 to 4 digital bit-outputs which represent
>> digital waveforms. These PWM outputs are primarily in charge of controlling
>> backlight LED devices.
>>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
>> ---
>>  drivers/pwm/Kconfig   |   12 ++
>>  drivers/pwm/Makefile  |    1 +
>>  drivers/pwm/pwm-img.c |  270 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 283 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/pwm/pwm-img.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index ef2dd2e..6b4581a 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -110,6 +110,18 @@ config PWM_FSL_FTM
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-fsl-ftm.
>>
>> +config PWM_IMG

> This sounds really generic to me. Basically this says that every PWM IP
> developed by Imagination Technologies will be compatible with this one.
> It's typical to name modules after <vendor>-<soc> to avoid this type of
> ambiguity.

> Is there any reason why this can't be called PWM_IMG_PISTACHIO?

At this moment, this IP Block is available at least on one more SOC from Imagination Technologies.
It is possible that the IP will be available on more SOCs in future.

Shall we go ahead with PWM_IMG?

>> +     tristate "Imagination Technologies PWM driver"
>> +     depends on MFD_SYSCON
>> +     depends on HAS_IOMEM

> I think you'll need at least COMMON_CLK here as well.

OK. Will address in the next Patch set.

>> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
[...]
>> +/* PWM registers */
>> +#define CR_PWM_CTRL_CFG                              0x0000
>> +#define CR_PWM_CTRL_CFG_NO_SUB_DIV           0
>> +#define CR_PWM_CTRL_CFG_SUB_DIV0             1
>> +#define CR_PWM_CTRL_CFG_SUB_DIV1             2
>> +#define CR_PWM_CTRL_CFG_SUB_DIV0_DIV1                3
>> +#define CR_PWM_CTRL_CFG_DIV_SHIFT(ch)                ((ch) * 2 + 4)
>> +#define CR_PWM_CTRL_CFG_DIV_MASK             0x3
>> +
>> +#define CR_PWM_CH_CFG(ch)                    (0x4 + (ch) * 4)
>> +#define CR_PWM_CH_CFG_TMBASE_SHIFT           0
>> +#define CR_PWM_CH_CFG_DUTY_SHIFT             16

> What's with the CR_ prefix here? What does it stand for? Can't you just
> drop it?

CR stands for Control Register. We have picked it from the datasheet and wanted to make the
register names compatible with the same in the datasheet.

Hope Andrew agrees with Thierry's comments here. Hope we can drop it. 

Andrew, any comments here, please.

>> +#define CR_PERIP_PWM_PDM_CONTROL             0x0140
>> +#define CR_PERIP_PWM_PDM_CONTROL_CH_MASK     0x1
>> +#define CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)        ((ch) * 4)
>> +
>> +#define IMG_NUM_PWM                          4

> I don't think you need this. See below for more details.

OK. Will address in the next patch set.

>> +static inline void img_pwm_writel(struct img_pwm_chip *chip,
>> +                               unsigned int reg, unsigned long val)
>> +{
>> +     writel(val, chip->base + reg);
>> +}
>> +
>> +static inline unsigned int img_pwm_readl(struct img_pwm_chip *chip,
>> +                                      unsigned int reg)
>> +{
>> +     return readl(chip->base + reg);
>> +}

> readl() and writel() deal with u32 data, please use consistent types.

OK. Will address in the next patch set.

>> +static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                       int duty_ns, int period_ns)
>> +{
>> +     unsigned int div;
>> +     unsigned int duty_steps;
>> +     unsigned int tmbase_steps;
>> +     unsigned long val;
>> +     unsigned long mul;
>> +     unsigned long output_clk_hz;
>> +     unsigned long input_clk_hz;

> Many of these can be folded into single lines. And again, val is used to
> store register contents and should be u32.

Agree. Will address in the next patch set.

>> +     struct img_pwm_chip *pwm_chip;
>> +
>> +     pwm_chip = to_img_pwm_chip(chip);
>> +
>> +     input_clk_hz = clk_get_rate(pwm_chip->pwm_clk);
>> +     output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
>> +
>> +     mul = DIV_ROUND_UP(input_clk_hz, output_clk_hz);
>> +     if (mul > MAX_TMBASE_STEPS * 512) {
>> +             dev_err(chip->dev,
>> +                     "failed to configure timebase steps/divider value.\n");
>> +             return -EINVAL;
>> +     }

> I think it'd be more readable if this was the final else in the block of
> if/else if below.

OK. Will address in the next patch set.

>> +
>> +     if (mul <= MAX_TMBASE_STEPS) {
>> +             div = CR_PWM_CTRL_CFG_NO_SUB_DIV;
>> +             tmbase_steps = DIV_ROUND_UP(mul, 1);
>> +     } else if (mul <= MAX_TMBASE_STEPS * 8) {
>> +             div = CR_PWM_CTRL_CFG_SUB_DIV0;
>> +             tmbase_steps = DIV_ROUND_UP(mul, 8);
>> +     } else if (mul <= MAX_TMBASE_STEPS * 64) {
>> +             div = CR_PWM_CTRL_CFG_SUB_DIV1;
>> +             tmbase_steps = DIV_ROUND_UP(mul, 64);
>> +     } else if (mul <= MAX_TMBASE_STEPS * 512) {
>> +             div = CR_PWM_CTRL_CFG_SUB_DIV0_DIV1;
>> +             tmbase_steps = DIV_ROUND_UP(mul, 512);
>> +     }
>> +
>> +     duty_steps = DIV_ROUND_UP(tmbase_steps * duty_ns, period_ns);
>> +
>> +     val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
>> +     val &= ~(CR_PWM_CTRL_CFG_DIV_MASK <<
>> +                                     CR_PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
>> +     val |= (div & CR_PWM_CTRL_CFG_DIV_MASK) <<
>> +                                     CR_PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm);

> If you leave out the CR_ prefix these will actually fit on a single
> line.

OK. Will address in the next patch set.

>> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
>> +
>> +     val = (duty_steps << CR_PWM_CH_CFG_DUTY_SHIFT) |
>> +                             (tmbase_steps << CR_PWM_CH_CFG_TMBASE_SHIFT);

> I prefer subsequent lines to be aligned with the first, like so:

OK. Will address in the next patch set.

>        val = (duty_steps ...) |
>              (tmbase_steps ...);

> Also I'd leave out the _steps suffix, it doesn't really add information.

OK. Will address in the next patch set.

>> +static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     unsigned int val;

> Should be u32 as well. There are other occurrences like this in the
> remainder of the driver, but I haven't commented on all of them
> explicitly. Please fix them all up to be consistent.

OK. Will fix the issue at all the places in the driver.

>> +     struct img_pwm_chip *pwm_chip;
>> +
>> +     pwm_chip = to_img_pwm_chip(chip);

> The above can be a single line.

OK. Will address in the next patch set.

>> +
>> +     val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
>> +     val |= BIT(pwm->hwpwm);
>> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
>> +
>> +     regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);

> This smells like pinmux and should probably be a separate driver.

Hope you are suggesting us to have a separate driver for pin muxing (might already have one for Pistachio)
and call the pin muxing driver APIs from here.

Please correct me if my understanding is wrong? 

>> +static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     unsigned int val;
>> +     struct img_pwm_chip *pwm_chip;
>> +
>> +     pwm_chip = to_img_pwm_chip(chip);
>> +
>> +     val = img_pwm_readl(pwm_chip, CR_PWM_CTRL_CFG);
>> +     val &= ~BIT(pwm->hwpwm);
>> +     img_pwm_writel(pwm_chip, CR_PWM_CTRL_CFG, val);
>> +
>> +     regmap_update_bits(pwm_chip->periph_regs, CR_PERIP_PWM_PDM_CONTROL,
>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_MASK <<
>> +                        CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 1);
>> +}

> Same comments as for img_pwm_enable().

OK.

>> +static int img_pwm_probe(struct platform_device *pdev)
>> +{
[...]
>> +     pwm->chip.dev = &pdev->dev;
>> +     pwm->chip.ops = &img_pwm_ops;
>> +     pwm->chip.base = -1;
>> +     pwm->chip.npwm = IMG_NUM_PWM;

> You can directly substitute 4 here since it's the only place you need
> it.

OK. Will address in the next patch set.

>> +static int img_pwm_remove(struct platform_device *pdev)
>> +{
>> +     unsigned int i;
>> +     unsigned int val;
>> +
>> +     struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);

> This should go at the very top of the variable declarations.

OK. Will address in the next patch set.

>> +
>> +     for (i = 0; i < IMG_NUM_PWM; i++) {

> This would better be pwm_chip->chip.npwm.

OK. Will address in the next patch set.

> Thierry

Thanks and regards,
Naidu.
