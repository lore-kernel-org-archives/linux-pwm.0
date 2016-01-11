From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix broken PWM backlight for non-dt
 platforms
Date: Mon, 11 Jan 2016 06:35:36 +0000
Message-ID: <20160111063536.GT3331@x1>
References: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, kernel@pengutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 10 Dec 2015, Philipp Zabel wrote:

> Commit ee65ad0e2a9e ("backlight: pwm_bl: Avoid backlight flicker when
> probed from DT") tries to dereference the device of_node pointer
> unconditionally, causing a NULL pointer dereference on non-dt platfor=
ms.
> Fix it by replacing the phandle variable with a node variable and
> by checking that for NULL before dereferencing it.
>=20
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index 3daf9cc..a22c1ec 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -198,8 +198,8 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	struct platform_pwm_backlight_data defdata;
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
> +	struct device_node *node =3D pdev->dev.of_node;
>  	struct pwm_bl_data *pb;
> -	phandle phandle =3D pdev->dev.of_node->phandle;
>  	int initial_blank =3D FB_BLANK_UNBLANK;
>  	int ret;
> =20
> @@ -273,7 +273,7 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  		 * assume that another driver will enable the backlight at the
>  		 * appropriate time. Therefore, if it is disabled, keep it so.
>  		 */
> -		if (phandle &&
> +		if (node && node->phandle &&
>  		    gpiod_get_direction(pb->enable_gpio) =3D=3D GPIOF_DIR_OUT &&
>  		    gpiod_get_value(pb->enable_gpio) =3D=3D 0)
>  			initial_blank =3D FB_BLANK_POWERDOWN;
> @@ -287,12 +287,11 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>  		goto err_alloc;
>  	}
> =20
> -	if (phandle && !regulator_is_enabled(pb->power_supply))
> +	if (node && node->phandle && !regulator_is_enabled(pb->power_supply=
))
>  		initial_blank =3D FB_BLANK_POWERDOWN;
> =20
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> -	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER
> -	    && !pdev->dev.of_node) {
> +	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER && !node=
) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy =3D true;
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
