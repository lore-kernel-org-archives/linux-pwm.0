Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40716 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731766AbfGHPvH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jul 2019 11:51:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so7682079lff.7
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2019 08:51:06 -0700 (PDT)
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f5f0a790-3ed5-dfbc-e489-be1ecc55d742@cogentembedded.com>
Date: Mon, 8 Jul 2019 18:51:00 +0300
MIME-Version: 1.0
In-Reply-To: <1562576868-8124-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 1/7] pinctrl: sh-pfc: add new flags into struct
 sh_pfc_pin_config
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On 08.07.2019 12:07, Yoshihiro Shimoda wrote:

> To clean/modify the code up later, this patch just adds new flags
> "mux_set" and "gpio_enabled" into the struct sh_pfc_pin_config.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/pinctrl/sh-pfc/pinctrl.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
> index 2824be4..157b257 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -27,6 +27,8 @@
>   
>   struct sh_pfc_pin_config {
>   	u32 type;
> +	bool mux_set;
> +	bool gpio_enabled;
>   };
>   
>   struct sh_pfc_pinctrl {
> @@ -364,7 +366,15 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
>   	for (i = 0; i < grp->nr_pins; ++i) {
>   		ret = sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION);
>   		if (ret < 0)
> -			break;
> +			goto done;
> +	}
> +
> +	/* All group pins are configurated, mark the pins as mux_set */

    Configured.

> +	for (i = 0; i < grp->nr_pins; ++i) {
> +		int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
> +		struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
> +
> +		cfg->mux_set = true;
>   	}
>   
>   done:
[...]

MBR, Sergei
