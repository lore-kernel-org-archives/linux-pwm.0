Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Thu, 11 Oct 2018 20:15:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] pwm: lpss: Move struct pwm_lpss_chip definition
 to the header file
Message-ID: <20181011171518.GP15943@smile.fi.intel.com>
References: <20181011161444.328-1-hdegoede@redhat.com>
 <20181011161444.328-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011161444.328-3-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Oct 11, 2018 at 06:14:43PM +0200, Hans de Goede wrote:
> Move struct pwm_lpss_chip definition from pwm-lpss.c to pwm-lpss.h,
> so that the pci/platform drivers can access the info member
> (struct pwm_lpss_boardinfo *).
> 
> This is a preparation patch for adding platform specific quirks, which
> the drivers need access to, to pwm_lpss_boardinfo.


Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> -No changes in v4 of this patch-set
> 
> Changes in v3:
> -There was no v3, but I accidentally put v3 in the Subject of the v2
>  patches, so lets skip v3
> 
> Changes in v2:
> -No changes in v2 of this patch-set
> ---
>  drivers/pwm/pwm-lpss.c | 9 ---------
>  drivers/pwm/pwm-lpss.h | 9 ++++++++-
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 4721a264bac2..e602835fd6de 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -32,15 +32,6 @@
>  /* Size of each PWM register space if multiple */
>  #define PWM_SIZE			0x400
>  
> -#define MAX_PWMS			4
> -
> -struct pwm_lpss_chip {
> -	struct pwm_chip chip;
> -	void __iomem *regs;
> -	const struct pwm_lpss_boardinfo *info;
> -	u32 saved_ctrl[MAX_PWMS];
> -};
> -
>  static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
>  {
>  	return container_of(chip, struct pwm_lpss_chip, chip);
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 7a4238ad1fcb..8f029ed263af 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -16,7 +16,14 @@
>  #include <linux/device.h>
>  #include <linux/pwm.h>
>  
> -struct pwm_lpss_chip;
> +#define MAX_PWMS			4
> +
> +struct pwm_lpss_chip {
> +	struct pwm_chip chip;
> +	void __iomem *regs;
> +	const struct pwm_lpss_boardinfo *info;
> +	u32 saved_ctrl[MAX_PWMS];
> +};
>  
>  struct pwm_lpss_boardinfo {
>  	unsigned long clk_rate;
> -- 
> 2.19.0
> 

-- 
With Best Regards,
Andy Shevchenko
