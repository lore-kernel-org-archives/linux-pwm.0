From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 0/3] FTM PWM adds regmap and endianness support.
Date: Thu, 10 Apr 2014 06:05:31 +0000
Message-ID: <1e190701f1b54403b94057472c7cbc56@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:46423
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933287AbaDJGFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Apr 2014 02:05:52 -0400
In-Reply-To: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Therry,

Ping :)



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Friday, March 21, 2014 12:53 PM
> To: thierry.reding@gmail.com; linux-pwm@vger.kernel.org
> Cc: broonie@kernel.org; swarren@nvidia.com; linux-kernel@vger.kernel.org;
> Xiubo Li-B47053
> Subject: [PATCH 0/3] FTM PWM adds regmap and endianness support.
> 
> 
> Xiubo Li (3):
>   pwm: ftm-pwm: Clean up the code.
>   pwm: ftm-pwm: Convert to direct regmap API usage.
>   pwm: ftm-pwm: Add big-endian support
> 
>  drivers/pwm/pwm-fsl-ftm.c | 96 ++++++++++++++++++++++++++--------------------
> -
>  1 file changed, 53 insertions(+), 43 deletions(-)
> 
> --
> 1.8.4
> 

