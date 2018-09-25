Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Tue, 25 Sep 2018 12:09:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] pwm: lpss: Release runtime-pm reference from the
 driver's remove callback
Message-ID: <20180925090923.GS15943@smile.fi.intel.com>
References: <20180925072536.17406-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925072536.17406-1-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Sep 25, 2018 at 09:25:35AM +0200, Hans de Goede wrote:
> For each pwm output which gets enabled through pwm_lpss_apply(), we do a
> pm_runtime_get_sync().
> 
> This commit adds pm_runtime_put() calls to pwm_lpss_remove() to balance
> these when the driver gets removed with some of the outputs still enabled.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Fixes: f080be27d7d9 ("pwm: lpss: Add support for runtime PM")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -New patch in v2 of this patch-set replacing "pwm: lpss: Add
>  pwm_lpss_get_put_runtime_pm helper function"
> ---
>  drivers/pwm/pwm-lpss.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index e602835fd6de..723ca9de8325 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -205,6 +205,12 @@ EXPORT_SYMBOL_GPL(pwm_lpss_probe);
>  
>  int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
>  {
> +	int i;
> +
> +	for (i = 0; i < lpwm->info->npwm; i++) {
> +		if (pwm_is_enabled(&lpwm->chip.pwms[i]))
> +			pm_runtime_put(lpwm->chip.dev);
> +	}
>  	return pwmchip_remove(&lpwm->chip);
>  }
>  EXPORT_SYMBOL_GPL(pwm_lpss_remove);
> -- 
> 2.19.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko
