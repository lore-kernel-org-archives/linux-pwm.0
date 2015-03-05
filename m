From: "Zha, Qipeng" <qipeng.zha@intel.com>
Subject: RE: [PATCH] pwm: mxs: fix period divider computation
Date: Thu, 5 Mar 2015 01:16:37 +0000
Message-ID: <C6287702A945AC47BE5DB5DFD4B5C6DD0184478B@SHSMSX104.ccr.corp.intel.com>
References: <1424264794-12167-1-git-send-email-ghug@induct.be>
 <20150302123206.GD3040@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30592 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbbCEBQr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Mar 2015 20:16:47 -0500
In-Reply-To: <20150302123206.GD3040@dragon>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi 

I got pwm subsystem git tree info as below from v3.19-rc6 MAINTAINER
And I clone it, found the version is v3.12
Is the tree current maintain tree ? or there is a new one, thanks.

git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 

Best wishes
Qipeng

-----Original Message-----
From: linux-pwm-owner@vger.kernel.org [mailto:linux-pwm-owner@vger.kernel.org] On Behalf Of Shawn Guo
Sent: Monday, March 02, 2015 8:32 PM
To: Gaetan Hug
Cc: thierry.reding@gmail.com; linux-pwm@vger.kernel.org; linux-kernel@vger.kernel.org; fabio.estevam@freescale.com
Subject: Re: [PATCH] pwm: mxs: fix period divider computation

On Wed, Feb 18, 2015 at 02:06:34PM +0100, Gaetan Hug wrote:
> The driver computes which clock divider it sould be using from the 
> requested period. This computation assumes that the link between the 
> register value and the actual divider value is raising 2 to the power 
> of the registry value.
> 
>     div = 1 << regvalue
> 
> This is true only for the first 5 values out of 8. Next values are 64,
> 256 and, 1024 - instead of 32, 64, 128.

Just checked i.MX28 Reference Manual, and yes, this is the case.

> This affects only the users requesting a period > 0.04369s.
> 
> Replace the computation with a look-up table.

Your SoB is missing here.  Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/pwm/pwm-mxs.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c index 
> f75ecb0..c65e183 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -35,6 +35,8 @@
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  
> +static unsigned const int cdiv[PERIOD_CDIV_MAX] = {1, 2, 4, 8, 16, 
> +64, 256, 1024};
> +
>  struct mxs_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> @@ -54,13 +56,13 @@ static int mxs_pwm_config(struct pwm_chip *chip, 
> struct pwm_device *pwm,
>  
>  	rate = clk_get_rate(mxs->clk);
>  	while (1) {
> -		c = rate / (1 << div);
> +		c = rate / cdiv[div];
>  		c = c * period_ns;
>  		do_div(c, 1000000000);
>  		if (c < PERIOD_PERIOD_MAX)
>  			break;
>  		div++;
> -		if (div > PERIOD_CDIV_MAX)
> +		if (div >= PERIOD_CDIV_MAX)
>  			return -EINVAL;
>  	}
>  
> --
> 1.7.10.4
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-pwm" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
