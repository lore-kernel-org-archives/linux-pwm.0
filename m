From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Tue, 23 Aug 2016 13:08:12 -0500
Message-ID: <20160823180812.GA2793@rob-hp-laptop>
References: <1471852213-86777-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36576 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbcHWSIO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Aug 2016 14:08:14 -0400
Content-Disposition: inline
In-Reply-To: <1471852213-86777-1-git-send-email-yuanjian12@hisilicon.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jian Yuan <yuanjian12@hisilicon.com>
Cc: thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com

On Mon, Aug 22, 2016 at 03:50:13PM +0800, Jian Yuan wrote:
> From: yuanjian <yuanjian12@hisilicon.com>
> 
> Add pwm driver for HiSilicon BVT SOCs
> 
> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
> ---
> Change Log:
> v2:
> The number of PWMs is change to be probeable based on the compatible string.
> 
>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

One comment though...

>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-hibvt.c                            | 274 +++++++++++++++++++++
>  4 files changed, 303 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>  create mode 100644 drivers/pwm/pwm-hibvt.c

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c182efc..3c48768 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -158,6 +158,15 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
>  
> +config PWM_HIBVT
> +	tristate "HiSilicon BVT PWM support"
> +	depends on ARCH_HISI

Add "|| COMPILE_TEST" so it can build test on other configs

> +	help
> +	  Generic PWM framework driver for hisilicon BVT SOCs.
> +
