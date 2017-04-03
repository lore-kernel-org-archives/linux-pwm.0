From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] pwm: lpss: Split Tangier configuration
Date: Mon, 03 Apr 2017 17:26:37 +0300
Message-ID: <1491229597.708.104.camel@linux.intel.com>
References: <20170403142508.40064-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3285 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbdDCO0l (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 Apr 2017 10:26:41 -0400
In-Reply-To: <20170403142508.40064-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Mon, 2017-04-03 at 17:25 +0300, Andy Shevchenko wrote:
> As a preparation for special treatment for Broxton we split Tangier
> configuration.

> Fixes: b89b4b7a3d0a ("pwm: lpss: pci: Enable PWM module on Intel
> Edison")

Fixes tag is present here to be sure we will apply it at least for
v4.11 cycle.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index 053088b9b66e..073dfb2337e0 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -38,6 +38,13 @@ static const struct pwm_lpss_boardinfo
> pwm_lpss_bxt_info = {
>  	.base_unit_bits = 22,
>  };
>  
> +/* Tangier */
> +static const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
> +	.clk_rate = 19200000,
> +	.npwm = 4,
> +	.base_unit_bits = 22,
> +};
> +
>  static int pwm_lpss_probe_pci(struct pci_dev *pdev,
>  			      const struct pci_device_id *id)
>  {
> @@ -97,7 +104,7 @@ static const struct pci_device_id
> pwm_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned
> long)&pwm_lpss_bxt_info},
>  	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned
> long)&pwm_lpss_byt_info},
>  	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned
> long)&pwm_lpss_byt_info},
> -	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned
> long)&pwm_lpss_bxt_info},
> +	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned
> long)&pwm_lpss_tng_info},
>  	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned
> long)&pwm_lpss_bxt_info},
>  	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned
> long)&pwm_lpss_bsw_info},
>  	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned
> long)&pwm_lpss_bsw_info},

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
