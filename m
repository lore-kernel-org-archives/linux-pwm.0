From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Subject: Re: [PATCH] pwm: imx: don't reprogram PWMSAR if PWM is disabled
Date: Fri, 1 Aug 2014 22:02:17 +0400
Message-ID: <CALT56yON=icaJZa22F30caYOGVLiHqBdXX2sfHqTBArd+PxrFA@mail.gmail.com>
References: <1406102987-14797-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:63477 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaHASCS (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Aug 2014 14:02:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so6422343iec.16
        for <linux-pwm@vger.kernel.org>; Fri, 01 Aug 2014 11:02:17 -0700 (PDT)
In-Reply-To: <1406102987-14797-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pwm@vger.kernel.org

On Wed, Jul 23, 2014 at 12:09 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
>
> Writing several values to PWMSAR register with PWM being disabled can
> lead to FIFO (connected to PWMSAR) being overflown. Then after enabling
> PWM, hardware will use stale values. Instead cache the duty cycles and
> write them to the hardware only before enabling PWM.

What about this patch?

>
> Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> ---
>  drivers/pwm/pwm-imx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index c735127..79c2b24 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -46,6 +46,7 @@ struct imx_chip {
>         struct clk      *clk_ipg;
>
>         void __iomem    *mmio_base;
> +       unsigned long   duty_cycles;
>
>         struct pwm_chip chip;
>
> @@ -105,7 +106,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  {
>         struct imx_chip *imx = to_imx_chip(chip);
>         unsigned long long c;
> -       unsigned long period_cycles, duty_cycles, prescale;
> +       unsigned long period_cycles, prescale;
>         u32 cr;
>
>         c = clk_get_rate(imx->clk_per);
> @@ -118,7 +119,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>         period_cycles /= prescale;
>         c = (unsigned long long)period_cycles * duty_ns;
>         do_div(c, period_ns);
> -       duty_cycles = c;
> +       imx->duty_cycles = c;
>
>         /*
>          * according to imx pwm RM, the real period value should be
> @@ -134,7 +135,8 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>
>         period_cycles -= 2;
>
> -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +       if (test_bit(PWMF_ENABLED, &pwm->flags))
> +               writel(imx->duty_cycles, imx->mmio_base + MX3_PWMSAR);
>         writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>
>         cr = readl(imx->mmio_base + MX3_PWMCR);
> @@ -157,6 +159,9 @@ static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
>         struct imx_chip *imx = to_imx_chip(chip);
>         u32 val;
>
> +       if (enable)
> +               writel(imx->duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +
>         val = readl(imx->mmio_base + MX3_PWMCR);
>
>         if (enable)
> --
> 1.9.3
>
