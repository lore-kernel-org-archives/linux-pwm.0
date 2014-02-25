From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv9 Resend 0/4] Add Freescale FTM PWM driver
Date: Tue, 25 Feb 2014 02:25:09 +0000
Message-ID: <beb8e719664148948f31026aaa01fb40@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:28712
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751422AbaBYCZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2014 21:25:12 -0500
In-Reply-To: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>

Thierry, Ping ? :)



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Wednesday, February 19, 2014 4:39 PM
> To: thierry.reding@gmail.com; linux-pwm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCHv9 Resend 0/4] Add Freescale FTM PWM driver
> 
> Resend this patch series, just adding the missing and new Reviewed-by and
> Acked-by infomation of this patch series.
> 
> 
> Xiubo Li (4):
>   pwm: Add Freescale FTM PWM driver support
>   ARM: dts: vf610: Add Freescale FTM PWM node.
>   ARM: dts: vf610-twr: Enables FTM PWM device.
>   Documentation: Add device tree bindings for Freescale FTM PWM.
> 
>  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  34 ++
>  arch/arm/boot/dts/vf610-twr.dts                    |   6 +
>  arch/arm/boot/dts/vf610.dtsi                       |  13 +
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-fsl-ftm.c                          | 479
> +++++++++++++++++++++
>  6 files changed, 543 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
>  create mode 100644 drivers/pwm/pwm-fsl-ftm.c
> 
> --
> 1.8.4
> 

