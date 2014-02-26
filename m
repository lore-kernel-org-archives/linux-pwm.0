From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 0/9] pwm: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 09:59:29 +0900
Message-ID: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28088 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbaBZA7c (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 19:59:32 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K005CDW36GS20@mailout4.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 09:59:30 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

Jingoo Han (9):
      pwm: ab8500: Remove unnecessary OOM messages
      pwm: i.MX: Remove unnecessary OOM messages
      pwm: pxa: Remove unnecessary OOM messages
      pwm: renesas-tpu: Remove unnecessary OOM messages
      pwm: spear: Remove unnecessary OOM messages
      pwm: tegra: Remove unnecessary OOM messages
      pwm: pwm-tiecap: Remove unnecessary OOM messages
      pwm: tiehrpwm: Remove unnecessary OOM messages
      pwm: vt8500: Remove unnecessary OOM messages

---
 drivers/pwm/pwm-ab8500.c      |    4 +---
 drivers/pwm/pwm-imx.c         |    4 +---
 drivers/pwm/pwm-pxa.c         |    4 +---
 drivers/pwm/pwm-renesas-tpu.c |    4 +---
 drivers/pwm/pwm-spear.c       |    4 +---
 drivers/pwm/pwm-tegra.c       |    4 +---
 drivers/pwm/pwm-tiecap.c      |    4 +---
 drivers/pwm/pwm-tiehrpwm.c    |    4 +---
 drivers/pwm/pwm-vt8500.c      |    4 +---
 9 files changed, 9 insertions(+), 27 deletions(-)

