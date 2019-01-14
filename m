From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: imx: Fix undefined symbol
Date: Mon, 14 Jan 2019 09:55:12 +0100
Message-ID: <20190114085512.uq3triamuufzknql@pengutronix.de>
References: <20190114081558.GA7897@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114081558.GA7897@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Jan 14, 2019 at 02:15:58AM -0600, Gustavo A. R. Silva wrote:
> Fix the following compile error:
> 
> drivers/pwm/pwm-imx27.c:292:25: error: 'imx_pwm_dt_ids' undeclared
> here (not in a function); did you mean 'pwm_imx27_dt_ids'?
> 
> Fixes: 5a309d380019 ("pwm: imx: Split into two drivers")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pwm/pwm-imx27.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 8997c4c1bd03..55666cca4cee 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -289,7 +289,7 @@ static const struct of_device_id pwm_imx27_dt_ids[] = {
>  	{ .compatible = "fsl,imx27-pwm", },
>  	{ /* sentinel */ }
>  };
> -MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
> +MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);

The patch is fine, you're at least the fourth person noticing this
problem (but the first to send an applicable patch). So if Thierry
doesn't want to squash the fix into the offending commit (which I would
prefer to not break bisecability), taking this one is the next best
option.

If so:
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards and thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
