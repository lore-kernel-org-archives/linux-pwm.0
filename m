From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] pwm: atmel: Remove redundant of_match_ptr helper
Date: Mon, 13 Jan 2014 08:39:44 +0530
Message-ID: <CAK9yfHy4C=i4zq0wPZ5yQESir3AKukVr-LhRs9aCtn50V8dZKg@mail.gmail.com>
References: <1387619866-21492-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:41926 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaAMDJp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Jan 2014 22:09:45 -0500
Received: by mail-ob0-f171.google.com with SMTP id wm4so801523obc.16
        for <linux-pwm@vger.kernel.org>; Sun, 12 Jan 2014 19:09:44 -0800 (PST)
In-Reply-To: <1387619866-21492-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>

On 21 December 2013 15:27, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'atmel_pwm_dt_ids' is always compiled in. Hence the
> helper macro is not needed.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-atmel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 657e90ab6e0a..cd6459e80690 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -379,7 +379,7 @@ static int atmel_pwm_remove(struct platform_device *pdev)
>  static struct platform_driver atmel_pwm_driver = {
>         .driver = {
>                 .name = "atmel-pwm",
> -               .of_match_table = of_match_ptr(atmel_pwm_dt_ids),
> +               .of_match_table = atmel_pwm_dt_ids,
>         },
>         .id_table = atmel_pwm_devtypes,
>         .probe = atmel_pwm_probe,
> --
> 1.7.9.5
>

Gentle ping.

-- 
With warm regards,
Sachin
