From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv2 0/4] FTM PWM adds regmap and endianness support.
Date: Tue, 13 May 2014 06:32:25 +0000
Message-ID: <6abc1298f24d45b1b126f48527299f52@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2on0070.outbound.protection.outlook.com ([207.46.100.70]:26034
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751043AbaEMHEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 13 May 2014 03:04:46 -0400
In-Reply-To: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Thierry,

Ping:)



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Tuesday, April 29, 2014 11:34 AM
> To: thierry.reding@gmail.com; linux-pwm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCHv2 0/4] FTM PWM adds regmap and endianness support.
> 
> Convert to direct regmap API usage. Since the regmap core has already
> support rich endianness modes of device, this patch convert to direct
> regmap API usage, preparing to support big endianness for LS1 SoC.
> 
> Using the regmag framework will be more easy to support the endiannesses
> switching of one same device driver on different SoCs.
> 
> The endianness scenarios are:
> SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
> --------|--------|---------|---------------------------------
> Vybird  |  LE    |   LE    |     No
> LS1     |  LE    |   BE    |     Yes
> LS2     |  LE    |   LE    |     No
> 
> 
> 
> Changes in V2:
> - Adds detail descriptions of these patches.
> 
> 
> Xiubo Li (4):
>   Documentation: Add 'big-endian' property for FTM PWM.
>   pwm: ftm-pwm: Clean up the code.
>   pwm: ftm-pwm: Convert to direct regmap API usage.
>   pwm: ftm-pwm: Add big-endian support
> 
>  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 12 ++-
>  drivers/pwm/pwm-fsl-ftm.c                          | 96 ++++++++++++---------
> -
>  2 files changed, 64 insertions(+), 44 deletions(-)
> 
> --
> 1.8.4

