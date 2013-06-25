Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH -next] pwm: renesas-tpu: fix return value check in tpu_probe()
Date: Tue, 25 Jun 2013 10:59:49 +0200
Message-ID: <19060081.EBSPSCq8RF@avalon>
In-Reply-To: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
References: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>, axel.lin@ingics.com
Cc: thierry.reding@gmail.com, yongjun_wei@trendmicro.com.cn, linux-pwm@vger.kernel.org

Hi Wei,

Thank you for the patch.

On Tuesday 25 June 2013 10:09:57 Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

With the change noted below,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thierry, do you need a v2, or can you fix the patch while applying ?

> ---
>  drivers/pwm/pwm-renesas-tpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 96e0cc4..70950e5 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -410,9 +410,9 @@ static int tpu_probe(struct platform_device *pdev)
>  	}
> 
>  	tpu->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (tpu->base == NULL) {
> +	if (IS_ERR(tpu->base)) {
>  		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> -		return -ENXIO;
> +		return PTR_ERR(tpu->base);
>  	}

You can remove the dev_err call well, devm_ioremap_resource() prints an error 
message already.

  	tpu->base = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(tpu->base))
		return PTR_ERR(tpu->base);

> 
>  	tpu->clk = devm_clk_get(&pdev->dev, NULL);

-- 
Regards,

Laurent Pinchart
