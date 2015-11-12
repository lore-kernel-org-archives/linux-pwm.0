From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] pwm: sun4i: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 15:47:01 +0100
Message-ID: <20151112144701.GD4230@piout.net>
References: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48249 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752821AbbKLOrE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2015 09:47:04 -0500
Content-Disposition: inline
In-Reply-To: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, thierry.reding@gmail.com, wens@csie.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 12/11/2015 at 08:42:12 +0100, LABBE Corentin wrote :
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
> 
> Reported-by: coverity (CID 1324139)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index cd9dde5..3011fcc 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -291,6 +291,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  
>  	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
>  

This will never happen. If it is not matching, then sun4i_pwm_probe is
not called.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
