From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2 0/3] pwm: ftm: add Power Management support
Date: Tue, 28 Oct 2014 06:01:31 +0000
Message-ID: <549e977528334f08a2652eda14a6ee6e@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry, 

Ping...


Thanks,

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
