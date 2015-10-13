From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v2] pwm: lpss: add PM support for LPSS PWM
Date: Tue, 13 Oct 2015 16:51:37 +0300
Message-ID: <20151013135137.GQ1492@lahna.fi.intel.com>
References: <1444381373-17791-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62124 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932190AbbJMNvl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 13 Oct 2015 09:51:41 -0400
Content-Disposition: inline
In-Reply-To: <1444381373-17791-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, Huiquan Zhong <huiquan.zhong@intel.com>

On Fri, Oct 09, 2015 at 05:02:53PM +0800, Qipeng Zha wrote:
> Add runtime PM and use autosuspend feature with
> default timeout of 5ms.
> PWM support D3 and DevIdle/D0i3 on Broxton,
> if PWM is in D0, then SOC will not enter S0ix.
> 
> Signed-off-by: Huiquan Zhong <huiquan.zhong@intel.com>
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> 
> ---
> change in v2
>  Change runtime get/put flow for pwm, get in enable and put in disable;
>  For platform device driver, call runtime_pm_enable when init;
>  Remove _resume stub function.
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 11 +++++++++++
>  drivers/pwm/pwm-lpss-platform.c | 11 +++++++++++
>  drivers/pwm/pwm-lpss.c          | 24 ++++++++++++++++++++++++
>  drivers/pwm/pwm-lpss.h          |  1 +
>  4 files changed, 47 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index 45042c1..e8c31d6 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "pwm-lpss.h"
>  
> @@ -33,6 +34,12 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
>  		return PTR_ERR(lpwm);
>  
>  	pci_set_drvdata(pdev, lpwm);
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 5);
> +	pm_runtime_use_autosuspend(&pdev->dev);

Why autosuspend?

> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
> +
>  	return 0;
>  }
>  
> @@ -40,6 +47,7 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
>  {
>  	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
>  
> +	pm_runtime_forbid(&pdev->dev);
>  	pwm_lpss_remove(lpwm);
>  }
>  
> @@ -59,6 +67,9 @@ static struct pci_driver pwm_lpss_driver_pci = {
>  	.id_table = pwm_lpss_pci_ids,
>  	.probe = pwm_lpss_probe_pci,
>  	.remove = pwm_lpss_remove_pci,
> +	.driver = {
> +		.pm = &pwm_lpss_pm,
> +	},
>  };
>  module_pci_driver(pwm_lpss_driver_pci);
>  
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
> index 18a9c88..829e222 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "pwm-lpss.h"
>  
> @@ -36,6 +37,12 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
>  		return PTR_ERR(lpwm);
>  
>  	platform_set_drvdata(pdev, lpwm);
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 5);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);

So you enable runtime PM here...

> +
>  	return 0;
>  }
>  
> @@ -43,6 +50,7 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
>  {
>  	struct pwm_lpss_chip *lpwm = platform_get_drvdata(pdev);
>  
> +	pm_runtime_forbid(&pdev->dev);

...but forbid it here (note it is different from _disable()).

How well have you tested this patch? Does PM still work if you
load/unload the module few times?

>  	return pwm_lpss_remove(lpwm);
>  }
