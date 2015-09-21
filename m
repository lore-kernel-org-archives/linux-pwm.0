From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH] backlight: pwm: free pwm requested by legacy API on error
 path
Date: Mon, 21 Sep 2015 18:15:38 +0300
Message-ID: <56001F1A.3040108@mentor.com>
References: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:44242 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbbIUPRD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2015 11:17:03 -0400
In-Reply-To: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Lee, Thierry,

On 14.06.2015 17:32, Vladimir Zapolskiy wrote:
> If pwm is requested by legacy pwm_request() and if the following
> backlight_device_register() call fails, add pwm_free() clean-up.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9991cdb..a691247 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		ret = PTR_ERR(bl);
> +		if (pb->legacy)
> +			pwm_free(pb->pwm);
>  		goto err_alloc;
>  	}
>  
> 

could you please apply this trivial fix?

Thank you in advance.

--
With best wishes,
Vladimir
