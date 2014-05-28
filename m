From: Liu Ying <Ying.Liu@freescale.com>
Subject: Re: [PATCH] pwm: i.MX: Cleanup indentation for register definitions
Date: Wed, 28 May 2014 18:12:45 +0800
Message-ID: <5385B69D.50508@freescale.com>
References: <1401185980-29536-1-git-send-email-Ying.Liu@freescale.com>
 <20140528115636.4ad791aa@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140528115636.4ad791aa@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 05/28/2014 05:56 PM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Liu Ying wrote:
>> This patch contains no logic change to cleanup indentation
>> for register definitions only.
>>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawn.guo@freescale.com>
>> Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
>> Cc: linux-pwm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>>  drivers/pwm/pwm-imx.c |   26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
>> index cc47733..0784554 100644
>> --- a/drivers/pwm/pwm-imx.c
>> +++ b/drivers/pwm/pwm-imx.c
>> @@ -21,24 +21,24 @@
>> =20
>>  /* i.MX1 and i.MX21 share the same PWM function block: */
>> =20
>> -#define MX1_PWMC    0x00   /* PWM Control Register */
>> -#define MX1_PWMS    0x04   /* PWM Sample Register */
>> -#define MX1_PWMP    0x08   /* PWM Period Register */
>> +#define MX1_PWMC			0x00   /* PWM Control Register */
>> +#define MX1_PWMS			0x04   /* PWM Sample Register */
>> +#define MX1_PWMP			0x08   /* PWM Period Register */
>> =20
>> -#define MX1_PWMC_EN		(1 << 4)
>> +#define MX1_PWMC_EN			(1 << 4)
>> =20
>>  /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
>> =20
>> -#define MX3_PWMCR                 0x00    /* PWM Control Register *=
/
>> -#define MX3_PWMSAR                0x0C    /* PWM Sample Register */
>> -#define MX3_PWMPR                 0x10    /* PWM Period Register */
>> -#define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
>> -#define MX3_PWMCR_DOZEEN                (1 << 24)
>> -#define MX3_PWMCR_WAITEN                (1 << 23)
>> +#define MX3_PWMCR			0x00    /* PWM Control Register */
>> +#define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>> +#define MX3_PWMPR			0x10    /* PWM Period Register */
>> +#define MX3_PWMCR_PRESCALER(x)		(((x - 1) & 0xFFF) << 4)
>                                                    ^
> You could also add the missing () around the macro argument when you
> are changing this line anyway.
>=20

I may generate a separate patch to do that.

Thanks.

>=20
> Lothar Wa=C3=9Fmann
>=20

--=20
Liu Ying
