From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH v3 0/2] Add MediaTek display PWM driver
Date: Mon, 29 Jun 2015 23:03:29 +0800
Message-ID: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:47518 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753325AbbF2PEM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2015 11:04:12 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com

This patch series add the use of display PWM driver and documentation 
for Mediatek SoCs. The driver is used to support the backlight of 
the panel. This is based on v4.1-rc1.

Change in v3:
1. Add suspend/resume function
2. Fix the formula for high_width calculation
3. Rewrite some code to make it easier to read
4. Add more information in the commit message
