From: Liu Ying <Ying.Liu@freescale.com>
Subject: Re: [PATCH v3] pwm: i.MX: Avoid sample FIFO overflow for i.MX PWM
 version2
Date: Mon, 19 May 2014 14:52:03 +0800
Message-ID: <5379AA13.4000904@freescale.com>
References: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
 <20140519075328.7f2ef0c5@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:9633
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750740AbaESGt2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 19 May 2014 02:49:28 -0400
In-Reply-To: <20140519075328.7f2ef0c5@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, linux-arm-kernel@lists.infradead.org

Hi Lothar,

Thanks for your review.

On 05/19/2014 01:53 PM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Liu Ying wrote:
> [...]
>> @@ -30,6 +32,7 @@
>>  /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
>> =20
>>  #define MX3_PWMCR                 0x00    /* PWM Control Register *=
/
>> +#define MX3_PWMIR                 0x08    /* PWM Interrupt Register=
 */
>>  #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
>>  #define MX3_PWMPR                 0x10    /* PWM Period Register */
>>  #define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
>> @@ -38,7 +41,12 @@
>>  #define MX3_PWMCR_DBGEN			(1 << 22)
>>  #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
>>  #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
>> +#define MX3_PWMCR_SWR		  (1 << 3)
>>  #define MX3_PWMCR_EN              (1 << 0)
>> +#define MX3_PWMSR_ROV             (1 << 4)
>> +#define MX3_PWMIR_RIE             (1 << 1)
>> +
> You should decide whether to use tabs or spaces for indentation.
> And probably cleanup the indentation of the existing definitions to u=
se
> all the same indentation style.

Ok, I will generate a separate patch to cleanup the indentation for
the existing register definitions of both i.MX PWMv1 and PWMv2.

>=20
>> @@ -128,6 +160,13 @@ static int imx_pwm_config_v2(struct pwm_chip *c=
hip,
>>  	else
>>  		period_cycles =3D 0;
>> =20
>> +	if (!enable || duty_cycles =3D=3D 0)
>> +		imx_pwm_software_reset_v2(chip);
>> +	else if (readl(imx->mmio_base + MX3_PWMSAR))
>> +		/* No rollover irq generated if duty peroid is zero. */
> typo: 'period'.

I will fix this.

>=20
>> @@ -135,27 +174,55 @@ static int imx_pwm_config_v2(struct pwm_chip *=
chip,
>>  		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
>>  		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
>> =20
>> -	if (test_bit(PWMF_ENABLED, &pwm->flags))
>> +	if (enable)
>>  		cr |=3D MX3_PWMCR_EN;
>> =20
>>  	writel(cr, imx->mmio_base + MX3_PWMCR);
>> =20
>> +	if (enable && duty_cycles)
>> +		/* No rollover irq generated if duty peroid is zero. */
> dto.

I will fix this.

>=20
>=20
> Lothar Wa=C3=9Fmann
>=20

--=20
Liu Ying
