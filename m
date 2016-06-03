From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 12/14] regulator: pwm: Retrieve correct voltage
Date: Fri, 3 Jun 2016 13:55:40 -0700
Message-ID: <20160603205540.GJ124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-13-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32982 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352AbcFCUzn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 16:55:43 -0400
Received: by mail-pf0-f174.google.com with SMTP id b124so47077866pfb.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jun 2016 13:55:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464942192-25967-13-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com

On Fri, Jun 03, 2016 at 10:23:10AM +0200, Boris Brezillon wrote:
> The continuous PWM voltage regulator is caching the voltage value in
> the ->volt_uV field. While most of the time this value should reflect the
> real voltage, sometime it can be sightly different if the PWM device
> rounded the set_duty_cycle request.
> Moreover, this value is not valid until someone has modified the regulator
> output.
> 
> Remove the ->volt_uV field and always rely on the PWM state to calculate
> the regulator output.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Mark,
> 
> I know you already added your Tested-by/Acked-by tags on this patch
> but this version has slightly change and is now making use of the
> pwm_get_relative_duty_cycle() helper instead of manually converting
> the absolute duty_cycle value into a relative one.
> ---
>  drivers/regulator/pwm-regulator.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index 8c56e16..c39ecd1 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -35,9 +35,6 @@ struct pwm_regulator_data {
>  	struct regulator_ops ops;
>  
>  	int state;
> -
> -	/* Continuous voltage */
> -	int volt_uV;
>  };
>  
>  struct pwm_voltages {
> @@ -135,8 +132,13 @@ static int pwm_regulator_is_enabled(struct regulator_dev *dev)
>  static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
>  {
>  	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
> +	int min_uV = rdev->constraints->min_uV;
> +	int diff = rdev->constraints->max_uV - min_uV;
> +	struct pwm_state pstate;
>  
> -	return drvdata->volt_uV;
> +	pwm_get_state(drvdata->pwm, &pstate);
> +
> +	return min_uV + pwm_get_relative_duty_cycle(&pstate, diff);
>  }
>  
>  static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
> @@ -162,8 +164,6 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
>  		return ret;
>  	}
>  
> -	drvdata->volt_uV = min_uV;
> -
>  	/* Delay required by PWM regulator to settle to the new voltage */
>  	usleep_range(ramp_delay, ramp_delay + 1000);
>  

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
