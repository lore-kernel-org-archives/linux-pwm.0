From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 RESEND] video: backlight: pwm_bl: Initialize
 fb_bl_on[x] and use_count during pwm_backlight_probe()
Date: Tue, 24 Jan 2017 09:37:08 +0000
Message-ID: <20170124093708.GV16020@dell>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
 <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35376 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdAXJdL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Jan 2017 04:33:11 -0500
Received: by mail-wm0-f51.google.com with SMTP id r126so172186678wmr.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jan 2017 01:33:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Ying <Ying.Liu@freescale.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Mon, 26 Dec 2016, Lukasz Majewski wrote:

> The commit a55944ca82d2 
> ("backlight: update bd state & fb_blank properties when necessary")
> has posed some extra restrictions on blanking and unblanking frame buffer
> device.
> 
> Unfortunately, pwm_bl driver's probe did not initialize members of
> struct backlight_device necessary for further blank/unblank operation.
> 
> This code in case of initial unblank of backlight device (default 
> behaviour) sets use_count to 1 and marks this particular backlight device
> as used by all available fb devices (since it is not known during probe 
> how much and which fb devices will be assigned).
> 
> Without this code, the backlight works properly until one tries to blank it
> manually from sysfs with "echo 1 > /sys/class/graphics/fb0/blank".
> Since fb_bl_on[0] and use_count were both set to 0, the logic at
> fb_notifier_callback (@backlight.c) thought that we didn't turn on
> (unblanked) the backlight device and refuses to disable (blank) it.
> As a result we see garbage from fb displayed.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> ---
> The patch has been tested on i.MX6q with vanilla 4.9 kernel.
> It applies on 4.10-rc1.
> ---
>  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Applied with Thierry's crazy Ack.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 1261400..6859ba0 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -202,7 +202,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	struct pwm_bl_data *pb;
>  	int initial_blank = FB_BLANK_UNBLANK;
>  	struct pwm_args pargs;
> -	int ret;
> +	int ret, i;
>  
>  	if (!data) {
>  		ret = pwm_backlight_parse_dt(&pdev->dev, &defdata);
> @@ -348,6 +348,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  	bl->props.brightness = data->dft_brightness;
>  	bl->props.power = initial_blank;
> +
> +	if (initial_blank == FB_BLANK_UNBLANK) {
> +		for (i = 0; i < FB_MAX; i++)
> +			bl->fb_bl_on[i] = true;
> +
> +		bl->use_count = 1;
> +	}
> +
>  	backlight_update_status(bl);
>  
>  	platform_set_drvdata(pdev, bl);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
