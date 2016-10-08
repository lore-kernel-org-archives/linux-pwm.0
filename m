From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3] pwm: add depends, COMPILE_TEST and default y for
 brcm-iproc-pwm
Date: Sat, 8 Oct 2016 14:02:51 -0700
Message-ID: <8b29ebaa-eaaa-2f77-6408-a476af3aaa84@broadcom.com>
References: <1475960045-19313-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36074 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbcJHVCy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Oct 2016 17:02:54 -0400
Received: by mail-pa0-f52.google.com with SMTP id ry6so35677859pac.3
        for <linux-pwm@vger.kernel.org>; Sat, 08 Oct 2016 14:02:53 -0700 (PDT)
In-Reply-To: <1475960045-19313-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>



On 10/8/2016 1:54 PM, Scott Branden wrote:
> - Add depends on COMMON_CLK for PWM_BCM_IPROC
> - Enable COMPILE_TEST for broader compile coverage.
> - Default y for IPROC PWM driver for IPROC SoCs.
> This allows you to turn it on simply by selecting CONFIG_PWM.
>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pwm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 80a566a..3eb1b6b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -76,7 +76,9 @@ config PWM_ATMEL_TCB
>
>  config PWM_BCM_IPROC
>  	tristate "iProc PWM support"
> -	depends on ARCH_BCM_IPROC
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	depends on COMMON_CLK
> +	default ARCH_BCM_IPROC
>  	help
>  	  Generic PWM framework driver for Broadcom iProc PWM block. This
>  	  block is used in Broadcom iProc SoC's.
>

Looks good to me!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
