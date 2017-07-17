From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: make of_device_ids const
Date: Mon, 17 Jul 2017 13:21:44 +0100
Message-ID: <20170717122144.hw72eeqiobfdkhtv@dell>
References: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: thierry.reding@gmail.com, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 20 Jun 2017, Arvind Yadav wrote:

> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 002f1ce..9bd1768 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  	return 0;
>  }
>  
> -static struct of_device_id pwm_backlight_of_match[] = {
> +static const struct of_device_id pwm_backlight_of_match[] = {
>  	{ .compatible = "pwm-backlight" },
>  	{ }
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
