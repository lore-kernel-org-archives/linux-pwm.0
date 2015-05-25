From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v2 0/2] Add MediaTek display PWM driver
Date: Mon, 25 May 2015 10:14:51 +0800
Message-ID: <1432520091.23308.5.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:43092 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751588AbbEYCO4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2015 22:14:56 -0400
In-Reply-To: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org

On Thu, 2015-05-21 at 21:29 +0800, YH Huang wrote:
> YH Huang (2):
>   dt-bindings: pwm: add MediaTek display PWM bindings
>   pwm: add MediaTek display PWM driver support
> 
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  25 +++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-mtk-disp.c                         | 228 +++++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c

Hi YH,

It would be easier for reviewer if you have a summary here on what you
have changed compare to last version.
Also, please add patch series summary even for v2, it remind reviewer
what this series is about.

Joe.C
