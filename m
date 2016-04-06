From: Simon Horman <horms@verge.net.au>
Subject: Re: [v3,1/6] pwm: rcar: Use ARCH_RENESAS
Date: Wed, 6 Apr 2016 10:18:34 +0900
Message-ID: <20160406011834.GI27262@verge.net.au>
References: <1459424356-26061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55382 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbcDFBSi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Apr 2016 21:18:38 -0400
Content-Disposition: inline
In-Reply-To: <1459424356-26061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, magnus.damm@gmail.com, Ryo Kodama <ryo.kodama.vz@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>

On Thu, Mar 31, 2016 at 01:39:11PM +0200, Ulrich Hecht wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
> 
> Replace ARCH_RCAR_GEN{1,2} with ARCH_RENESAS in order to support R-Car Gen3.
> 
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c182efc..3a2e232 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -305,7 +305,7 @@ config PWM_PXA
>  
>  config PWM_RCAR
>  	tristate "Renesas R-Car PWM support"
> -	depends on ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help
>  	  This driver exposes the PWM Timer controller found in Renesas
