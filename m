From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] pwm: pxa: Use of_match_ptr helper
Date: Mon, 13 Jan 2014 08:39:26 +0530
Message-ID: <CAK9yfHybHj2UmHHuav1cJUW-RSLTEhZK=SF_0AAMZrXOuteJ8A@mail.gmail.com>
References: <1387612250-7704-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:63779 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaAMDJ1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Jan 2014 22:09:27 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so7034509obc.7
        for <linux-pwm@vger.kernel.org>; Sun, 12 Jan 2014 19:09:27 -0800 (PST)
In-Reply-To: <1387612250-7704-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>

On 21 December 2013 13:20, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Use the helper instead of defining NULL for CONFIG_OF
> disabled case.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-pxa.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 3dc7c10bb7a0..5d25e4217542 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
>
>  #include <asm/div64.h>
> @@ -140,13 +141,12 @@ static struct of_device_id pwm_of_match[] = {
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, pwm_of_match);
> -#else
> -#define pwm_of_match NULL
>  #endif
>
>  static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>  {
> -       const struct of_device_id *id = of_match_device(pwm_of_match, dev);
> +       const struct of_device_id *id;
> +       id = of_match_device(of_match_ptr(pwm_of_match), dev);
>
>         return id ? id->data : NULL;
>  }
> @@ -228,7 +228,7 @@ static struct platform_driver pwm_driver = {
>         .driver         = {
>                 .name   = "pxa25x-pwm",
>                 .owner  = THIS_MODULE,
> -               .of_match_table = pwm_of_match,
> +               .of_match_table = of_match_ptr(pwm_of_match),
>         },
>         .probe          = pwm_probe,
>         .remove         = pwm_remove,
> --
> 1.7.9.5
>

Gentle ping.

-- 
With warm regards,
Sachin
