From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v2] pwm: add COMPILE_TEST and default y for brcm-iproc-pwm
Date: Sat, 8 Oct 2016 13:20:13 -0700
Message-ID: <377829f9-05b3-6407-477c-52c23f623368@broadcom.com>
References: <1475948189-6402-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35368 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbcJHUVQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Oct 2016 16:21:16 -0400
Received: by mail-qk0-f176.google.com with SMTP id z190so57181726qkc.2
        for <linux-pwm@vger.kernel.org>; Sat, 08 Oct 2016 13:20:17 -0700 (PDT)
In-Reply-To: <1475948189-6402-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>

Hi Scott,

On 10/8/2016 10:36 AM, Scott Branden wrote:
> Enable COMPILE_TEST for broader compile coverage.
> Default y for IPROC PWM driver for IPROC SoCs.
> This allows you to turn it on simply by selecting CONFIG_PWM.
>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pwm/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 80a566a..68cd13d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -76,7 +76,8 @@ config PWM_ATMEL_TCB
>   
>   config PWM_BCM_IPROC
>   	tristate "iProc PWM support"
> -	depends on ARCH_BCM_IPROC
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
Would be nice to also add a dependency on COMMON_CLK here.

> +	default ARCH_BCM_IPROC
>   	help
>   	  Generic PWM framework driver for Broadcom iProc PWM block. This
>   	  block is used in Broadcom iProc SoC's.

Thanks,

Ray
