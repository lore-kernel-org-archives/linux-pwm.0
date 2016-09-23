From: Jonathan Liu <net147@gmail.com>
Subject: Re: [1/2] pwm: sunxi: allow the pwm to finish its pulse before disable
Date: Sat, 24 Sep 2016 00:02:13 +1000
Message-ID: <CANwerB2LwWShNEUmNNbuH_4GY90gSpVmrxbC+oLK4p51cxUe2g@mail.gmail.com>
References: <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36200 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034358AbcIWOCO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Sep 2016 10:02:14 -0400
In-Reply-To: <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: oliver@schinagl.nl
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 26 August 2016 at 03:50,  <oliver@schinagl.nl> wrote:
> When we inform the PWM block to stop toggeling the output, we may end up
> in a state where the output is not what we would expect (e.g. not the
> low-pulse) but whatever the output was at when the clock got disabled.
>
> To counter this we have to wait for maximally the time of one whole
> period to ensure the pwm hardware was able to finish. Since we already
> told the PWM hardware to disable it self, it will not continue toggling
> but merly finish its current pulse.
>
> If a whole period is considered to much, it may be contemplated to use a
> half period + a little bit to ensure we get passed the transition.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/pwm-sun4i.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..5e97c8a 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>         spin_lock(&sun4i_pwm->ctrl_lock);
>         val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>         val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
> +       sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +       spin_unlock(&sun4i_pwm->ctrl_lock);
> +
> +       /* Allow for the PWM hardware to finish its last toggle. The pulse
> +        * may have just started and thus we should wait a full period.
> +        */
> +       ndelay(pwm_get_period(pwm));
> +
> +       spin_lock(&sun4i_pwm->ctrl_lock);
> +       val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>         val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>         sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
>         spin_unlock(&sun4i_pwm->ctrl_lock);

I had some issues where setting the brightness for pwm-backlight to 0
was not turning off the backlight sometimes.
This patch fixes the issue for me. Thanks.

Tested-by: Jonathan Liu <net147@gmail.com>
