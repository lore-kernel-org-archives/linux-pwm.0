From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/3] pwm: imx27: fix clk handling
Date: Mon, 10 Feb 2020 22:22:37 +0100
Message-ID: <20200210212240.25513-1-u.kleine-koenig@pengutronix.de>
References: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48825 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJVXC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Feb 2020 16:23:02 -0500
In-Reply-To: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello,

while looking through the pwm-imx27 driver I found some more broken
clock handling additional to yesterday's patch (pwm: imx27: fix clk
handling in pwm_imx27_apply()). This series is to be applied on top of
this patch.

Uwe Kleine-König (3):
  pwm: imx27: Simplify helper function to enable and disable clocks
  pwm: imx27: Don't disable clks at device remove time
  pwm: imx27: Ensure clocks being on iff the PWM is on

 drivers/pwm/pwm-imx27.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

-- 
2.24.0
