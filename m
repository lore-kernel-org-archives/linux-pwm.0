Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
Date: Fri, 22 Nov 2013 01:42:22 +0100
References: <1385055795-24002-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1385055795-24002-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201311220142.22605.marex@denx.de>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: thierry.reding@gmail.com, shawn.guo@linaro.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Fabio Estevam,

> Commit 22ceeee1 (pwm-backlight: Add power supply support) caused breakage
> on boards that do not define the backlight regulator on their dts files.
> 
> Instead of making the backlight regulator mandatory, treat it as optional
> instead, so that we do not have breakage.
> 
> This avoids the need for adding a dummy regulator on every dts file that
> uses the pwm-backlight.
> 
> Tested on a mx6qsabresd.

This patch certainly makes sense, there are plenty of simple boards that have no 
actual supply for the PWM.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
