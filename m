From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH] pwm: samsung: Allow samsung pwm driver to be enabled on Exynos7
Date: Fri, 14 Nov 2014 19:38:52 +0530
Message-ID: <CAM4voakoTjoeX=mShK7JeQK=as63o4WUvMx2sj35f+1qkJkeEA@mail.gmail.com>
References: <1414759126-4608-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:36561 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965136AbaKNOIx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Nov 2014 09:08:53 -0500
Received: by mail-qc0-f173.google.com with SMTP id x3so12831612qcv.18
        for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2014 06:08:53 -0800 (PST)
In-Reply-To: <1414759126-4608-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
Cc: Me2 <kesavan.abhilash@gmail.com>

Hi Thierry,

On Fri, Oct 31, 2014 at 6:08 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> To re-use the existing PWM driver for arm64 based exynos7 SoC,
> make the driver depend on ARCH_EXYNOS along with PLAT_SAMSUNG.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/pwm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index ef2dd2e..e82ab69 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -235,7 +235,7 @@ config PWM_ROCKCHIP
>
>  config PWM_SAMSUNG
>         tristate "Samsung PWM support"
> -       depends on PLAT_SAMSUNG
> +       depends on PLAT_SAMSUNG || ARCH_EXYNOS
>         help
>           Generic PWM framework driver for Samsung.

This is a minor change that makes it possible to re-use the samsung
pwm driver on the new 64-bit exynos7 soc. Can you please review ?

Regards,
Abhilash
>
> --
> 1.7.9.5
>
