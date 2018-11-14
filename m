From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
Date: Wed, 14 Nov 2018 13:08:14 +0100
Message-ID: <20181114120814.GD2620@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6233009531081371068=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, kernel@pengutronix.de, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--===============6233009531081371068==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:41:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The legacy PWM API should be removed in the long run, so convert a user
> to the atomic PWM API.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/=
mach-rx1950.c
> index 7f5a18fa305b..5c4459f9a5f7 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -375,6 +375,7 @@ static struct pwm_lookup rx1950_pwm_lookup[] =3D {
>  		   PWM_POLARITY_NORMAL),
>  };
> =20
> +static struct pwm_state lcd_pwm_state;

You shouldn't need this. The whole point of the atomic API is that the
PWM carries its state, so the proper way to make a change is to query
the current state, make any required modifications and then apply the
new state.

>  static struct pwm_device *lcd_pwm;
> =20
>  static void rx1950_lcd_power(int enable)
> @@ -428,15 +429,17 @@ static void rx1950_lcd_power(int enable)
> =20
>  		/* GPB1->OUTPUT, GPB1->0 */
>  		gpio_direction_output(S3C2410_GPB(1), 0);
> -		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> -		pwm_disable(lcd_pwm);
> +		lcd_pwm_state.duty_cycle =3D 0;
> +		lcd_pwm_state.enabled =3D false;
> +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);

The correct way to do this would be:

	struct pwm_state state;

	pwm_get_state(lcd_pwm, &state);
	state.enabled =3D false;
	state.duty_cycle =3D 0;
	pwm_apply_state(lcd_pwm, &state);

> =20
>  		/* GPC0->0, GPC10->0 */
>  		gpio_direction_output(S3C2410_GPC(0), 0);
>  		gpio_direction_output(S3C2410_GPC(10), 0);
>  	} else {
> -		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
> -		pwm_enable(lcd_pwm);
> +		lcd_pwm_state.duty_cycle =3D LCD_PWM_DUTY;
> +		lcd_pwm_state.enabled =3D true;
> +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);

Similarily here.

> =20
>  		gpio_direction_output(S3C2410_GPC(0), 1);
>  		gpio_direction_output(S3C2410_GPC(5), 1);
> @@ -491,11 +494,8 @@ static int rx1950_backlight_init(struct device *dev)
>  		return PTR_ERR(lcd_pwm);
>  	}
> =20
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to
> -	 * the atomic PWM API.
> -	 */
> -	pwm_apply_args(lcd_pwm);
> +	pwm_get_state_default(lcd_pwm, &lcd_pwm_state);
> +	lcd_pwm_state.period =3D LCD_PWM_PERIOD;

This is wrong, though it's probably because the comment is also
confusing. There should be nothing wrong with using pwm_apply_args() in
this case.

While at it, I think the conversion should also be include replacing the
call to pwm_request() by pwm_get(). There's already a PWM lookup table
in the RX1950 board code, so pwm_get() would be able to use that. Note
that for some reason that table contains a period that is different from
LCD_PWM_PERIOD, so I think that should also be addressed. Basically all
the information other than duty cycle should be coming from either DT or
a lookup table.

Thierry

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsECsACgkQ3SOs138+
s6F3Eg//Tuvrot17m5wGKoK61kVmNMp45oib1RKD0kiFxtZuPaeNV5YBUYzQNVrz
XvFqvIoemlSDH6SWeQA9Jh5FonV2yOH/jFPB5vyR4MAiGauqjcTjWwJHxQUlr1Up
C2EjzavnDbrUORSL1nzcp7q2+rtNjf+gTWVXcM4EIH9fZ87E3SHOkLVTi3c3lseT
sB4MXftPSSb1a8h7xOE8W+xcBszQj8J70OYG5j1uHXhsyVF5jS0tMhuZFTX/MHAd
YKrfbe/HBFN7fCb4NtXHnSiWTjH9pY4gTx53FJUYla7EugKXBeE7mRRnVhc4hWWb
W/n6r/d0xshjnNO9gpouJ6SEA++xE/8WhwaWRs18fOhrLwErLU179K146jE7cM/f
4HM27dfnwLPlBt6OTAyXJ+Aqz5lrkBaT2foM9SF/WUP15IvQHhe8haw/L78exFwv
U9ePUf4uf1rYBywFY8R+Uk82jZeqpxZe/LUoaAZUIASGiLF7NCDGbPwzv9hEs8SZ
quKK/cFteW8cQ8XIsTKYSX1Up4HREnBdLUAh5/j6qzdczNyQD8qm3MhIm9Meit11
WIEEFLcKw7lzqCcKbP6gT2EEzlElMLhT8qR1eKY3IgwDAid2XoIkvZ9aCV1U9Nbb
yfzO3M52AbqllNXIGt6mEVCxJ+pbSqTCdwKCisy5pblOQadSShc=
=Ceoa
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--


--===============6233009531081371068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6233009531081371068==--
