From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V3 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 14 Mar 2019 10:22:11 +0100
Message-ID: <20190314092211.rt36ynjjsdesszut@pengutronix.de>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
 <1552544534-5295-3-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1552544534-5295-3-git-send-email-Anson.Huang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm->
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 14, 2019 at 06:27:20AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, add TPM PWM driver support.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- Add "IMX_" as prefix to macro define as TPM is already used;
> 	- Use macro define for channel registers address instead of calculation =
in everywhere.
> 	- Add limitations statement in copyright.
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 343 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 354 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> =

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df..c1cbb43 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -201,6 +201,16 @@ config PWM_IMX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx.
>  =

> +config PWM_IMX_TPM
> +	tristate "i.MX TPM PWM support"
> +	depends on ARCH_MXC
> +	help
> +	  Generic PWM framework driver for i.MX7ULP TPM module, TPM's full
> +	  name is Low Power Timer/Pulse Width Modulation Module.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-imx-tpm.
> +
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9c676a0..64e036c 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX)		+=3D pwm-imx.o
> +obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> new file mode 100644
> index 0000000..cdb29f6
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + *
> + * Limitations:
> + * - The TPM counter and period counter are shared between
> + *   multiple channels, so all channels should use same period
> + *   settings.
> + * - When a channel is disabled, its polarity settings will be
> + *   saved and its output will be disabled by clearing polarity
> + *   setting, when channel is enabled, polarity settings will be
> + *   restored and output will be enabled again.
> + * - ONLY when all channels are disabled, then TPM counter will
> + *   be disabled.

I wouldn't list the last two items in this section. These are
implementation details that a PWM consumer doesn't need to bother with.
These are fine to be noted in a code comment at the appropriate place.

Other than that please look at my feedback for the previous series that
I just sent out. I think most things still apply to this version.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
