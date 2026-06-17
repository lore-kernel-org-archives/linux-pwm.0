Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6F3CE4A3;
	Wed, 17 Jun 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690296; cv=none; b=Xl2E/2Zg+QAGZFa2KqVDMo5ch7OEqfV3ql8ZjplL6pvK02EuWwchbbUppQf2AjL3Tw4AS7aoqSkxPHNY4ajy01o6Sw+mMREMb3/nWlMY2SZE1fo0o95WkK0T+8pA1hz3LT3PmRfcusbVAYn7kxkSXf5mOTSAxsbWD/Qo8tH9y6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690296; c=relaxed/simple;
	bh=+ndcSoGZm49UtMp4jBGHTFV2C8LSvo9Cf1fRV5Ed1Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F97ixOl+fxUYKPuN2WpRO1CdpCfwzZDot99PZyOTUR7r2i8Gvw62RGWIpjcmcv8YQ9SYW/YIGwaLQMiilIT7GrHyRq/qLvPg3dFXB8G9hUAcQK2JpqSYHSInjrQgpI+DbMT4aSGc2Xc4DnWc5Yn5zqKgh4IT1Jt9P1XoH0jLl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZSIbktkV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZSIbktkV"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1ECC32F8;
	Wed, 17 Jun 2026 11:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1781690259;
	bh=+ndcSoGZm49UtMp4jBGHTFV2C8LSvo9Cf1fRV5Ed1Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSIbktkVruY1N01c2q4AL5f+cnGjtMvzN65rHEBAbfN0u3+4ksTwbitqAo+a4H5Jx
	 BsiVUWloH3Wy9RjuJMSyGo77I6YdgewrpEvYa2RC2Gk42GDujXma5C1qacqY6222Q/
	 xQumZjfwJ0WkfcfQXLgHOPjxD8OuXmyuq36OASEM=
Date: Wed, 17 Jun 2026 12:58:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: Use named initializers for platform_device_id
 arrays
Message-ID: <20260617095811.GG3054789@killaraus.ideasonboard.com>
References: <b515eb1644e793d019163fd2a717d3fccef857f5.1781689255.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b515eb1644e793d019163fd2a717d3fccef857f5.1781689255.git.u.kleine-koenig@baylibre.com>

On Wed, Jun 17, 2026 at 11:41:50AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
> 
> While touching these arrays drop a comma after a list terminator.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-adp5585.c |  4 ++--

For this driver,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/pwm/pwm-pxa.c     | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index 806f8d79b0d7..f4aa74b44ed2 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -203,8 +203,8 @@ static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
>  };
>  
>  static const struct platform_device_id adp5585_pwm_id_table[] = {
> -	{ "adp5585-pwm", (kernel_ulong_t)&adp5585_pwm_chip_info },
> -	{ "adp5589-pwm", (kernel_ulong_t)&adp5589_pwm_chip_info },
> +	{ .name = "adp5585-pwm", .driver_data = (kernel_ulong_t)&adp5585_pwm_chip_info },
> +	{ .name = "adp5589-pwm", .driver_data = (kernel_ulong_t)&adp5589_pwm_chip_info },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 80d2fa10919f..b844bb2dd92e 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -32,12 +32,12 @@
>  #define HAS_SECONDARY_PWM	0x10
>  
>  static const struct platform_device_id pwm_id_table[] = {
> -	/*   PWM    has_secondary_pwm? */
> -	{ "pxa25x-pwm", 0 },
> -	{ "pxa27x-pwm", HAS_SECONDARY_PWM },
> -	{ "pxa168-pwm", 0 },
> -	{ "pxa910-pwm", 0 },
> -	{ },
> +	/*             PWM            has_secondary_pwm? */
> +	{ .name = "pxa25x-pwm", .driver_data = 0 },
> +	{ .name = "pxa27x-pwm", .driver_data = HAS_SECONDARY_PWM },
> +	{ .name = "pxa168-pwm", .driver_data = 0 },
> +	{ .name = "pxa910-pwm", .driver_data = 0 },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, pwm_id_table);
>  
> 
> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9

-- 
Regards,

Laurent Pinchart
