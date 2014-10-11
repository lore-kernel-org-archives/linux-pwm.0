From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 0/2] backlight: pwm: fix oops on accessing removed legacy pwm device
Date: Sat, 11 Oct 2014 16:46:24 +0300
Message-ID: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:61161 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaJKNqh (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Oct 2014 09:46:37 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org

The changeset fixes an oops, if pwm device was allocated by calling
legacy API and not deregistered appropriately on removal:

  % dmesg | grep -i pwm
  pwm-backlight backlight.19: unable to request PWM, trying legacy API
  % rmmod pwm_bl
  % cat /sys/kernel/debug/pwm
  Unable to handle kernel paging request at virtual address 7f0c18cc
  pgd = ace18000
  [7f0c18cc] *pgd=3c5eb811, *pte=00000000, *ppte=00000000
  Internal error: Oops: 7 [#1] PREEMPT SMP ARM
  ......

Vladimir Zapolskiy (2):
  backlight: pwm: don't call legacy pwm request for device defined in dt
  backlight: pwm: clean up pwm requested using legacy API

 drivers/video/backlight/pwm_bl.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
1.7.10.4

