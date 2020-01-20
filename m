From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: sun4i: Initialize variables before use
Date: Mon, 20 Jan 2020 21:09:17 +0100
Message-ID: <20200120200917.gvua5h2egoznwd4h@pengutronix.de>
References: <20200120143206.710666-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58693 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgATUJW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 15:09:22 -0500
Content-Disposition: inline
In-Reply-To: <20200120143206.710666-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Jan 20, 2020 at 03:32:06PM +0100, Thierry Reding wrote:
> GCC can't always determine that the duty, period and prescaler values
> are initialized when returning from sun4i_pwm_calculate(), so help out a
> little by initializing them to 0.

Is it worth mentioning the gcc version you're using?

> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 0decc7cde133..3e3efa6c768f 100644

I don't find this object (0decc7cde133) in my tree or next. Which
version is this?

> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -234,9 +234,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
>  	struct pwm_state cstate;
> -	u32 ctrl, duty, period, val;
> +	u32 ctrl, duty = 0, period = 0, val;

+     u32 ctrl, uninitialized_var(duty), uninitialized_var(period), val;

should fix the warnings, too, and additionally explicitly documents that
it's just the compiler that doesn't see there is no problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
