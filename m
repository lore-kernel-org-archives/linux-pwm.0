From: "Jingoo Han" <jingoohan1@gmail.com>
Subject: Re: [PATCH] video: backlight: pwm_bl: Initialize fb_bl_on[x] and use_count during pwm_backlight_probe()
Date: Sun, 23 Oct 2016 22:34:24 -0400
Message-ID: <000201d22d9f$22acb6c0$68062440$@gmail.com>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Lukasz Majewski' <l.majewski@majess.pl>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Fabio Estevam' <fabio.estevam@nxp.com>, 'Fabio Estevam' <festevam@gmail.com>, 'Liu Ying' <Ying.Liu@freescale.com>
List-Id: linux-pwm@vger.kernel.org

On Saturday, October 22, 2016, Lukasz Majewski wrote:
> 
> The commit: a55944ca82d287ca099ca90413af857af9086773 has posed some extra

Please add the subject of the patch, in order to let people know which patch
you mention exactly. Please loot at other commits that fixed bugs or
behavior
of other patches.

> restrictions on blanking and unblanking frame buffer device.
> 
> Unfortunately, pwm_bl driver's probe did not initialize members of struct
> backlight_device necessary for further blank/unblank operation.
> 
> This code in case of initial unblank of backlight device (default
> behaviour) sets use_count to 1 and marks this particular backlight device
> as used by all available fb devices (since it is not known during probe
> how much and which fb devices will be assigned).
> 
> Without this code, the backlight works properly until one tries to blank
> it manually from sysfs with "echo 1 > /sys/class/graphics/fb0/blank".
> Since fb_bl_on[0] and use_count were both set to 0, the logic at
> fb_notifier_callback (@backlight.c) thought that we didn't turn on
> (unblanked) the backlight device and refuses to disable (blank) it.
> As a result we see garbage from fb displayed.
> 
> 
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> ---
> The patch has been tested on i.MX6q with vanilla 4.7 and 4.8 kernels.
> It applies on 4.9-rcX SHA1: dcd4693cf47801b7d988ea897519de90dfd25d17.
> 
> ---
>  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c
> b/drivers/video/backlight/pwm_bl.c
> index 8040fd6..def39e8 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -203,7 +203,7 @@ static int pwm_backlight_probe(struct platform_device
> *pdev)
>  	struct pwm_bl_data *pb;
>  	int initial_blank = FB_BLANK_UNBLANK;
>  	struct pwm_args pargs;
> -	int ret;
> +	int ret, i;
> 
>  	if (!data) {
>  		ret = pwm_backlight_parse_dt(&pdev->dev, &defdata); @@ -
> 349,6 +349,14 @@ static int pwm_backlight_probe(struct platform_device
> *pdev)
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
> --
> 2.1.4
