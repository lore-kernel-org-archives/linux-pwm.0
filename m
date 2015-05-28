From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v4 0/2] pwm: Add support for R-Car PWM Timer
Date: Thu, 28 May 2015 10:11:43 +0000
Message-ID: <SG2PR06MB09199F8E4E836FE928B3A266D8CA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:9086 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752769AbbE1KLt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 28 May 2015 06:11:49 -0400
In-Reply-To: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: ja-JP
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>

Hi Thierry,

Would you apply this patch set to your repository?
I checked that I could apply this patch set correctly
on the latest linux-pwm.git / for-next branch.
(commit id = cccb94543c8299e0bc7564cc6f8b26e0f15bafde)

Best regards,
Yoshihiro Shimoda

> Sent: Thursday, May 21, 2015 7:57 PM
> 
> This patch set is based on the linux-pwm.git / for-next branch.
> (commit id = efb0de55b6a2ec15fc424e660601f22ae2fa487a)
> 
> Changes from v3:
>  - Fix register size in patch 1.
>  - Add "Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>" in patch 1
>  - Remove an unnecessary definition in patch 2.
>  - Use "ULL" to avoid overflow in patch 2.
>  - Remove unnecessary casts in patch 2.
> 
> Changes from v2:
>  - Add compatible string "renesas,pwm-rcar".
>  - Remove compatible strings "renesas,pwm-r8a77xx" in rcar_pwm_of_table.
>  - Fix build error.
> 
> Changes from v1:
>  - Change compatible string to SoC-specific compatible values.
>  - Fix #pwm-call value to 2 in the device tree document.
>  - Fix "depends on" value in Kconfig.
>  - Fix help explanation in Kconfig.
>  - Remove an unnecessary member in rcar_pwm_chip.
>  - Remove hardcoded number of channels and change chip.npwm value to 1.
>  - Fix formulas for clock calculation to improve accuracy.
> 
> Yoshihiro Shimoda (2):
>   pwm: Add device tree binding document for R-Car PWM Timer
>   pwm: Add support for R-Car PWM Timer
> 
>  .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  27 +++
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-rcar.c                             | 261 +++++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
>  create mode 100644 drivers/pwm/pwm-rcar.c
> 
> --
> 1.9.1
