From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/2] pwm: lpss: Split Tangier configuration
Date: Thu, 6 Apr 2017 14:14:41 +0200
Message-ID: <ae21c655-1ecd-895d-8bb1-007466a0b017@redhat.com>
References: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754726AbdDFMOn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 Apr 2017 08:14:43 -0400
In-Reply-To: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

I can confirm that this series fixes the issues I was seeing on
Cherry Trail devices:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


On 06-04-17 13:54, Andy Shevchenko wrote:
> As a preparation for special treatment for Broxton we split Tangier
> configuration.
>
> Fixes: b89b4b7a3d0a ("pwm: lpss: pci: Enable PWM module on Intel Edison")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index 053088b9b66e..073dfb2337e0 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -38,6 +38,13 @@ static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
>  	.base_unit_bits = 22,
>  };
>
> +/* Tangier */
> +static const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
> +	.clk_rate = 19200000,
> +	.npwm = 4,
> +	.base_unit_bits = 22,
> +};
> +
>  static int pwm_lpss_probe_pci(struct pci_dev *pdev,
>  			      const struct pci_device_id *id)
>  {
> @@ -97,7 +104,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
>  	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
>  	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
> -	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned long)&pwm_lpss_bxt_info},
> +	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned long)&pwm_lpss_tng_info},
>  	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
>  	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
>  	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
>
