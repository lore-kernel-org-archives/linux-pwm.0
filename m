From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Sun, 24 May 2020 18:16:44 +0200
Message-ID: <WVFUAQ.BITRQ3YW6GKI@crapouillou.net>
References: <20200413121445.72996-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413121445.72996-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

Any feedback on this patchset?

Cheers,
-Paul


Le lun. 13 avril 2020 =E0 14:14, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Depending on MACH_INGENIC prevent us from creating a generic kernel=20
> that
> works on more than one MIPS board. Instead, we just depend on MIPS=20
> being
> set.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index eebbc917ac97..7814e5b2cad7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -234,7 +234,7 @@ config PWM_IMX_TPM
>=20
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
> -	depends on MACH_INGENIC
> +	depends on MIPS
>  	depends on COMMON_CLK
>  	select MFD_SYSCON
>  	help
> --
> 2.25.1
>=20
