From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2 0/3] pwm: ftm: add Power Management support
Date: Mon, 1 Dec 2014 03:25:02 +0000
Message-ID: <BY2PR0301MB06135ED75E8DCEC04E442E0B9B7D0@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:35200
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752227AbaLADZH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Nov 2014 22:25:07 -0500
In-Reply-To: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Ping :) .

Thanks very much.

BRs
Xiubo



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Wednesday, October 15, 2014 1:22 PM
> To: thierry.reding@gmail.com; linux-pwm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCH v2 0/3] pwm: ftm: add Power Management support
> 
> Changes in v2:
> - Fix one bug.
> - Add regmap cache support.
> - Remove run time PM for now.
> 
> Xiubo Li (3):
>   pwm: ftm: fix one bug of wrong counting the use counter.
>   pwm: ftm: add regmap rbtree type cache support.
>   pwm: ftm: add Power Management support for FTM pwm.
> 
>  drivers/pwm/pwm-fsl-ftm.c | 64 ++++++++++++++++++++++++++++++++++++++++++++--
> -
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> --
> 2.1.0.27.g96db324

