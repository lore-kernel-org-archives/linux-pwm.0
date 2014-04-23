From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 0/9] pwm: Remove unnecessary OOM messages
Date: Wed, 23 Apr 2014 18:38:09 +0900
Message-ID: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33544 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122AbaDWJiM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Apr 2014 05:38:12 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H00JOT9FMN3D0@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 23 Apr 2014 18:38:10 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

These patches were expected to be applied to 3.15-rc1. [1]
However, it is not merged yet, so I resend these patches
based on 3.15-rc2.

[1] http://www.spinics.net/lists/linux-pwm/msg00976.html

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

