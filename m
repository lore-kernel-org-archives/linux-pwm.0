From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Date: Thu, 9 Jan 2020 08:44:45 +0100
Message-ID: <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
References: <20200109072735.GA22886@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200109072735.GA22886@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, Jernej Skrabec <jernej.skrabec@siol.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Gustavo,

On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> 
> The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
> Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1afd41ebd3fd..a805c347ee84 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	 */
>  	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
>  	if (IS_ERR(pwm->clk)) {
> -		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)

How embarrassing that I didn't notice these. Thanks for catching.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
