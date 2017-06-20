From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: make of_device_ids const
Date: Tue, 20 Jun 2017 11:52:30 +0100
Message-ID: <2574238d-640f-79b3-4650-c51766b4a478@linaro.org>
References: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37002 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdFTKwd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Jun 2017 06:52:33 -0400
Received: by mail-wm0-f50.google.com with SMTP id d73so16394364wma.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jun 2017 03:52:33 -0700 (PDT)
In-Reply-To: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, thierry.reding@gmail.com, lee.jones@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 20/06/17 08:52, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/pwm_bl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 002f1ce..9bd1768 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>   	return 0;
>   }
>   
> -static struct of_device_id pwm_backlight_of_match[] = {
> +static const struct of_device_id pwm_backlight_of_match[] = {
>   	{ .compatible = "pwm-backlight" },
>   	{ }
>   };
> 
