From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RESEND PATCH v2 1/4] pwm: Add support for Meson PWM Controller
Date: Mon, 22 Aug 2016 14:16:52 +0200
Message-ID: <ad2f719e-9236-96fd-3bea-ce20c487c67f@baylibre.com>
References: <1471718083-11516-1-git-send-email-narmstrong@baylibre.com>
 <1471718083-11516-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37128 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcHVMQz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Aug 2016 08:16:55 -0400
Received: by mail-wm0-f51.google.com with SMTP id i5so140883556wmg.0
        for <linux-pwm@vger.kernel.org>; Mon, 22 Aug 2016 05:16:55 -0700 (PDT)
In-Reply-To: <1471718083-11516-2-git-send-email-narmstrong@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Thierry,

On 08/20/2016 08:34 PM, Neil Armstrong wrote:
> Add support for the PWM controller found in the Amlogic SoCs.
> This driver supports the Meson8b and GXBB SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pwm/Kconfig     |   9 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-meson.c | 491 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 501 insertions(+)
>  create mode 100644 drivers/pwm/pwm-meson.c
> 

[...]

> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> new file mode 100644
> index 0000000..9e7ecf5
> --- /dev/null
> +++ b/drivers/pwm/pwm-meson.c

[...]

> +
> +static const char * const pwm_parents[] = {
> +	"xtal", "vid_pll", "fclk_div4", "fclk_div3", NULL
> +};

Aww, crap, it's "vid_pll" on meson8b and "hdmi_pll" for gxbb.
I'll add it to DT mach data.

> +static int meson_pwm_enable(struct pwm_chip *chip,
> +				 struct pwm_device *pwm)
> +{
> +	struct meson_pwm_chip *pwm_data = to_meson_pwm_chip(chip);
> +	unsigned int id = pwm->hwpwm;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pwm_data->lock, flags);
> +	switch (id) {
> +	case PWM_A:
> +		writel(readl(pwm_data->base + REG_MISC_AB) | MISC_A_EN,
> +			pwm_data->base + REG_MISC_AB);

Found an issue here, the HW requires to re-write the clock counts register even if the value is correct.
Let's got for a v3 !

> +		break;
> +
> +	case PWM_B:
> +		writel(readl(pwm_data->base + REG_MISC_AB) | MISC_B_EN,
> +			pwm_data->base + REG_MISC_AB);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +	spin_unlock_irqrestore(&pwm_data->lock, flags);
> +
> +	return 0;
> +}

Is it worth rewriting the driver using the apply callback ?
I'll wish to have it for 4.9 if possible, do you think it's possible ?

Neil
