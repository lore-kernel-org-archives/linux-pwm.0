Return-Path: <thierry.reding@gmail.com>
Date: Tue, 8 Oct 2013 13:49:02 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm_backlight: avoid short blank screen while doing
 hibernation
Message-ID: <20131008114901.GJ19633@ulmo.nvidia.com>
References: <1381050398-12565-1-git-send-email-Baohua.Song@csr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Content-Disposition: inline
In-Reply-To: <1381050398-12565-1-git-send-email-Baohua.Song@csr.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: rpurdie@rpsys.net, jg1.han@samsung.com, linux-pwm@vger.kernel.org, workgroup.linux@csr.com, Huayi Li <huayi.li@csr.com>, Barry Song <Baohua.Song@csr.com>


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2013 at 05:06:38PM +0800, Barry Song wrote:
> From: Huayi Li <huayi.li@csr.com>
>=20
> Use SIMPLE_DEV_PM_OPS macro will initialize the member "freeze"
> and "thaw" of pwm_backlight_pm_ops as below,
> 	.freeze =3D suspend_fn,
> 	.thaw =3D resume_fn,
> then during the process of making hibernation snapshot, screen
> will be blank at the moment of freezing, and then light at the
> moment of thawing.
> this is not the right user experience for suspending to disk.
>=20
> so this patch drops freeze and thaw callback, make the LCD is
> always lighting before the final shutdown.
>=20
> Signed-off-by: Huayi Li <huayi.li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

My notebook seems to disable the backlight when snapshotting so I guess
it provides the wrong user experience as well. What the commit message
says makes some sense, so I think I'll apply this. I have one comment,
though, see below.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 1fea627..f3b76cb 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -296,16 +296,23 @@ static int pwm_backlight_resume(struct device *dev)
>  	backlight_update_status(bl);
>  	return 0;
>  }
> +
> +static const struct dev_pm_ops pwm_backlight_pm_ops =3D {
> +	.suspend =3D pwm_backlight_suspend,
> +	.resume =3D pwm_backlight_resume,
> +	.poweroff =3D pwm_backlight_suspend,
> +	.restore =3D pwm_backlight_resume,
> +};
>  #endif
> =20
> -static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
> -			 pwm_backlight_resume);
> =20
>  static struct platform_driver pwm_backlight_driver =3D {
>  	.driver		=3D {
>  		.name		=3D "pwm-backlight",
>  		.owner		=3D THIS_MODULE,
> +#ifdef CONFIG_PM_SLEEP
>  		.pm		=3D &pwm_backlight_pm_ops,
> +#endif

Can we move the #ifdef inside of the pwm_backlight_pwm_ops so that we
don't have to clutter the platform_driver here? What I mean is this:

	static const struct dev_pm_ops pwm_backlight_pm_ops =3D {
	#ifdef CONFIG_PM_SLEEP
		.suspend =3D pwm_backlight_suspend,
		.resume =3D pwm_backlight_resume,
		.poweroff =3D pwm_backlight_suspend,
		.restore =3D pwm_backlight_resume,
	#endif
	};

That's consistent with what SIMPLE_DEV_PM_OPS() does.

Thanks,
Thierry

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSU/EtAAoJEN0jrNd/PrOhYYgQAJoGDuh7iXRbPTmzJzzboRZh
zTbFCj3Xnjn2dppLQOrAJN+WyNEVBKJcnDTFVjOgKCQnc0tiiauXcO/rl3Yo4jAK
F1votQU+2nERqPEZbkl7B9P/9dPnS98hwBqOGtOXJXy/FikeWJYU488rffSWhA0h
S+h+0PvJDweJQv5AgGHXMV1Qe1idA6134xOP4flv5DIrI0ENcKQpF9Tj1Osd3bre
CV8gl/uKru1rG+4YU2/hir/islgbCWHD1OlbrUW3Uc1leN5n7HGilgCxVBcI9RQc
JsaQ7oodzcmTKG3ANmAanILSoKKrFj3X+5C4NuwhkRsmxvbg7c9UEiIWh2uKuEUi
qk0HTaB/qznNXgZZ0Dgrq81ZJehbD7ZrWYaDm952G5x5n7QQu+CHlWYD41Id4bd9
xFyyfQNexHzi8EPOiSg74DdYYs5EFea/n67dW8GakrOVZtLKFyfa7o5ZKDAXL3WL
CWFcowy9TzwiZ4jOSACTtfWDfmnN7TPyY1rmPHKenRUHu6WhRy9Uij7cVDCdYrG8
Wu3rIU+4IfZAeT8wcvZrt6u5HtNJJg/ssd6kfXbtYfAt/7WNvnCnrsztHzGZQXyU
W4r+8+mL9GdW/0+fSh+ldG38oiCfKXscWOwHiKBYb58HjGVmY13ykQyaKH3ikoxZ
51orga016jZ+HT+knz2W
=JRkL
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
