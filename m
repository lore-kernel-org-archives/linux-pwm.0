From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: imx27: Eliminate error message for defer probe
Date: Mon, 30 Dec 2019 13:54:54 +0100
Message-ID: <20191230125454.7i4dahdc3wclpkgz@pengutronix.de>
References: <1577674960-12011-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1577674960-12011-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: thierry.reding@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 30, 2019 at 11:02:40AM +0800, Anson Huang wrote:
> For defer probe error, no need to output error message which
> will cause confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 59d8b12..35a7ac42 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -319,9 +319,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>  
>  	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> -				PTR_ERR(imx->clk_ipg));
> -		return PTR_ERR(imx->clk_ipg);
> +		int ret = PTR_ERR(imx->clk_ipg);
> +
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"getting ipg clock failed with %d\n",
> +				ret);

While you touch this part, you could convert to %pe to get a more
expressive error message.

But even independent of this the patch is fine, so

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
