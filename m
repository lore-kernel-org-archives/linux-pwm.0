From: Zhi Mao <zhi.mao@mediatek.com>
Subject: Re: [PATCH v3 0/6] mediatek: pwm driver add MT2712/MT7622 support
Date: Mon, 17 Jul 2017 11:16:04 +0800
Message-ID: <1500261364.22478.32.camel@mhfsdcap03>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "john@phrozen.org" <john@phrozen.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= <Yingjoe.Chen@mediatek.com>, YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= <Yt.Shen@mediatek.com>, Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?=
List-Id: linux-pwm@vger.kernel.org

Hi John, Matthais & PWM Maintainers

Just a Gentle ping on this issue :)
Is there anything should be modified?

Regards,
Zhi


On Fri, 2017-06-30 at 14:05 +0800, Zhi Mao wrote:
> change in v3:
> 1. add pwm clk disable in function:mtk_pwm_config()
>    for error parameter checking case
> 
> Zhi Mao (6):
>   pwm: kconfig: modify mediatek information
>   pwm: mediatek: fix pwm source clock selection
>   pwm: mediatek: fix clock control issue
>   pwm: bindings: add MT2712/MT7622 information
>   pwm: mediatek: add PWM_CLK_DIV_MAX
>   pwm: mediatek: add MT2712/MT7622 support
> 
>  .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
>  drivers/pwm/Kconfig                                |    2 +-
>  drivers/pwm/pwm-mediatek.c                         |  133 ++++++++++++++------
>  3 files changed, 104 insertions(+), 37 deletions(-)
> 
