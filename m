From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/7] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Fri, 09 Aug 2019 23:40:59 +0200
Message-ID: <1565386860.2091.5@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-4-paul@crapouillou.net>
        <20190809164143.2p573g7wlx43hero@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809164143.2p573g7wlx43hero@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org



Le ven. 9 ao=FBt 2019 =E0 18:41, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Fri, Aug 09, 2019 at 02:30:27PM +0200, Paul Cercueil wrote:
>>  Depending on MACH_INGENIC prevent us from creating a generic kernel=20
>> that
>>  works on more than one MIPS board. Instead, we just depend on MIPS=20
>> being
>>  set.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/pwm/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index d2557c6fcf65..82a75e0b72e5 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -224,7 +224,7 @@ config PWM_IMX_TPM
>>=20
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>  -	depends on MACH_INGENIC
>>  +	depends on MIPS
>=20
> If this isn't actually useful on MIPS without MACH_INGENIC this is
> better expressed using:
>=20
> 	depends on MIPS
> 	depends on MACH_INGENIC || COMPILE_TEST
>=20
> This way some configuring a mips kernel without INGENIC isn't bothered
> by this question.

As said in the commit message, it is useful on MIPS without=20
MACH_INGENIC,
if you want to create a generic kernel that works on more than one MIPS
board.


> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=
