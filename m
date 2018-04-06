Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:65161 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755402AbeDFOH5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Apr 2018 10:07:57 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] pwm: rcar: simplify getting .drvdata
Date: Fri, 6 Apr 2018 14:07:54 +0000
Message-ID: <TY1PR06MB09929D5E2BD4D1B193A72D23D8BA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Wolfram-san,

> From: Wolfram Sang, Sent: Friday, April 6, 2018 2:26 AM
>=20
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Only build tested. Fixed numerous times in other drivers, however...

Thank you for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

>  drivers/pwm/pwm-rcar.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 91d11f2e2fef..748f614d5375 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -261,8 +261,7 @@ MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
>  #ifdef CONFIG_PM_SLEEP
>  static struct pwm_device *rcar_pwm_dev_to_pwm_dev(struct device *dev)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	struct rcar_pwm_chip *rcar_pwm =3D platform_get_drvdata(pdev);
> +	struct rcar_pwm_chip *rcar_pwm =3D dev_get_drvdata(dev);
>  	struct pwm_chip *chip =3D &rcar_pwm->chip;
>=20
>  	return &chip->pwms[0];
> --
> 2.11.0

