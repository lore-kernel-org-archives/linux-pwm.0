From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] pwm: lpss: platform: Save/restore the ctrl register over a suspend/resume
Date: Thu, 10 May 2018 17:25:10 +0200
Message-ID: <2943907.WSHDcS9sfS@aspire.rjw.lan>
References: <20180426121024.22023-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180426121024.22023-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thursday, April 26, 2018 2:10:23 PM CEST Hans de Goede wrote:
> On some devices the contents of the ctrl register get lost over a
> suspend/resume and the PWM comes back up disabled after the resume.
> 
> This is seen on some Bay Trail devices with the PWM in ACPI enumerated
> mode, so it shows up as a platform device instead of a PCI device.
> 
> If we still think it is enabled and then try to change the duty-cycle
> after this, we end up with a "PWM_SW_UPDATE was not cleared" error and
> the PWM is stuck in that state from then on.
> 
> This commit adds suspend and resume pm callbacks to the pwm-lpss-platform
> code, which save/restore the ctrl register over a suspend/resume, fixing
> this.
> 
> Note that:
> 
> 1) There is no need to do this over a runtime suspend, since we
> only runtime suspend when disabled and then we properly set the enable
> bit and reprogram the timings when we re-enable the PWM.
> 
> 2) This may be happening on more systems then we realize, but has been
> covered up sofar by a bug in the acpi-lpss.c code which was save/restoring
> the regular device registers instead of the lpss private registers due to
> lpss_device_desc.prv_offset not being set. This is fixed by a later patch
> in this series.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Andy, Thierry, any comments or concerns regarding this series?

> ---
> Changes in v2:
> -Add Cc: stable@vger.kernel.org to make sure this goes into stable
>  together with "ACPI / LPSS: Add missing prv_offset setting for byt/cht
>  PWM devices" which depends on this
> ---
>  drivers/pwm/pwm-lpss-platform.c |  5 +++++
>  drivers/pwm/pwm-lpss.c          | 30 ++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-lpss.h          |  2 ++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
> index 5d6ed1507d29..5561b9e190f8 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -74,6 +74,10 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
>  	return pwm_lpss_remove(lpwm);
>  }
>  
> +static SIMPLE_DEV_PM_OPS(pwm_lpss_platform_pm_ops,
> +			 pwm_lpss_suspend,
> +			 pwm_lpss_resume);
> +
>  static const struct acpi_device_id pwm_lpss_acpi_match[] = {
>  	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
>  	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
> @@ -86,6 +90,7 @@ static struct platform_driver pwm_lpss_driver_platform = {
>  	.driver = {
>  		.name = "pwm-lpss",
>  		.acpi_match_table = pwm_lpss_acpi_match,
> +		.pm = &pwm_lpss_platform_pm_ops,
>  	},
>  	.probe = pwm_lpss_probe_platform,
>  	.remove = pwm_lpss_remove_platform,
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 8db0d40ccacd..4721a264bac2 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -32,10 +32,13 @@
>  /* Size of each PWM register space if multiple */
>  #define PWM_SIZE			0x400
>  
> +#define MAX_PWMS			4
> +
>  struct pwm_lpss_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
>  	const struct pwm_lpss_boardinfo *info;
> +	u32 saved_ctrl[MAX_PWMS];
>  };
>  
>  static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
> @@ -177,6 +180,9 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>  	unsigned long c;
>  	int ret;
>  
> +	if (WARN_ON(info->npwm > MAX_PWMS))
> +		return ERR_PTR(-ENODEV);
> +
>  	lpwm = devm_kzalloc(dev, sizeof(*lpwm), GFP_KERNEL);
>  	if (!lpwm)
>  		return ERR_PTR(-ENOMEM);
> @@ -212,6 +218,30 @@ int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
>  }
>  EXPORT_SYMBOL_GPL(pwm_lpss_remove);
>  
> +int pwm_lpss_suspend(struct device *dev)
> +{
> +	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < lpwm->info->npwm; i++)
> +		lpwm->saved_ctrl[i] = readl(lpwm->regs + i * PWM_SIZE + PWM);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwm_lpss_suspend);
> +
> +int pwm_lpss_resume(struct device *dev)
> +{
> +	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < lpwm->info->npwm; i++)
> +		writel(lpwm->saved_ctrl[i], lpwm->regs + i * PWM_SIZE + PWM);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwm_lpss_resume);
> +
>  MODULE_DESCRIPTION("PWM driver for Intel LPSS");
>  MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 98306bb02cfe..7a4238ad1fcb 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -28,5 +28,7 @@ struct pwm_lpss_boardinfo {
>  struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>  				     const struct pwm_lpss_boardinfo *info);
>  int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
> +int pwm_lpss_suspend(struct device *dev);
> +int pwm_lpss_resume(struct device *dev);
>  
>  #endif	/* __PWM_LPSS_H */
> 
