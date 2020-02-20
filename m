From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 26/32] pwm: mtk-disp: convert to
 devm_platform_ioremap_resource
Date: Thu, 20 Feb 2020 21:49:56 +0100
Message-ID: <12bba091-f095-8474-0032-e0d5acf3357c@gmail.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-26-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191229080610.7597-26-tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nsaenzjulienne-l3A5Bk7waGM@public.gmane.org, shc_work-JGs/UdohzUI@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org, paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM1dQTEkxZZdg@public.gmane.org
List-Id: linux-pwm@vger.kernel.org



On 29/12/2019 09:06, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/pwm/pwm-mtk-disp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 83b8be0209b7..87c6b4bc5d43 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -172,7 +172,6 @@ static const struct pwm_ops mtk_disp_pwm_ops = {
>  static int mtk_disp_pwm_probe(struct platform_device *pdev)
>  {
>  	struct mtk_disp_pwm *mdp;
> -	struct resource *r;
>  	int ret;
>  
>  	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
> @@ -181,8 +180,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>  
>  	mdp->data = of_device_get_match_data(&pdev->dev);
>  
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mdp->base = devm_ioremap_resource(&pdev->dev, r);
> +	mdp->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mdp->base))
>  		return PTR_ERR(mdp->base);
>  
> 
