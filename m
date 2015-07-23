From: Petr Cvek <petr.cvek@tul.cz>
Subject: [RFC] backlight: pwm: Handle EPROBE_DEFER while requesting the PWM
Date: Thu, 23 Jul 2015 02:15:54 +0200
Message-ID: <55B0323A.8060202@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:45808 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275AbbGWAW2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 22 Jul 2015 20:22:28 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: nicolas.ferre@atmel.com, lee.jones@linaro.org, boris.brezillon@free-electrons.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,
It seems, that commit

	68feaca0b13e453aa14ee064c1736202b48b342f

blocks the "legacy" call to request a PWM chip from PXA27x architecture (pwm_pxa). Checking for EPROBE_DEFER (default return from devm_pwm_get if pwm is not found) causes jump over it. Older versions of kernel (tested on 3.13-rc7) and modified 4.2.0-rc1 (commented goto) works. 

My question is: Should I write patch modifying error checking path or rather migrate legacy PXA driver to new API (I can only test pwm_pxa and only on one specific device)? 

Petr Cvek
